import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  final String produksiId;
  const ProductDetailPage({super.key, required this.produksiId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
   
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ProduksiViewModel>();
      final id = int.tryParse(widget.produksiId);
      if (id != null) {
        viewModel.loadProduksiForEdit(id);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProduksiViewModel>().clearEditingState();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProduksiViewModel>();
    final produksiHeader = viewModel.produksiToEdit;
    final itemList = viewModel.itemList;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detail Produksi',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/production');
          },
        ),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : produksiHeader == null
              ? const Center(child: Text('Data produksi tidak ditemukan.'))
              : _buildDetails(produksiHeader, itemList),
    );
  }

  Widget _buildDetails(ProduksiData header, List<ItemProduksiData> items) {
    final dateFormat = DateFormat('d MMMM yyyy');

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Informasi Pengiriman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildDetailItem('Tujuan', header.tujuanPengiriman),
        _buildDetailItem('Tanggal Kirim', dateFormat.format(header.tanggalPengiriman)),
        const Divider(height: 32),

        const Text(
          'Item Produksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const Center(child: Text('Belum ada item produksi untuk pengiriman ini.'))
        else
          ...items.map((item) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.namaProduk, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildDetailItem('Jumlah', '${item.jumlah} pcs'),
                      _buildDetailItem('Ukuran', item.ukuran),
                      _buildDetailItem('Tgl. Produksi', dateFormat.format(item.tanggalProduksi)),
                      if (item.deskripsi != null && item.deskripsi!.isNotEmpty)
                        _buildDetailItem('Catatan', item.deskripsi!),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
