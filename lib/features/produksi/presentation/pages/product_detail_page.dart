import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';
import 'package:seger/features/produksi/presentation/widgets/qr_code_display.dart';
import 'package:seger/features/produksi/presentation/widgets/product_item_list.dart';
import 'package:seger/features/produksi/presentation/widgets/shipping_info_section.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatefulWidget {
  final String produksiId;
  const ProductDetailPage({super.key, required this.produksiId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late GlobalKey<State<StatefulWidget>> qrKey;

  @override
  void initState() {
    super.initState();
    qrKey = GlobalKey();

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
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        ShippingInfoSection(produksiHeader: header),
        const SizedBox(height: 12),
        QrCodeDisplay(
          produksiId: widget.produksiId,
          qrKey: qrKey,
        ),
        const SizedBox(height: 32),
        ProductItemList(items: items),
      ],
    );
  }
}
