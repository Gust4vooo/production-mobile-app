import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app.database.dart';
import '../../../../core/widgets/add_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/search_bar.dart';
import '../viewmodels/produksi_view_model.dart';
import '../../domain/produksi_status.dart';
import '../../domain/produksi_status_utils.dart';
import '../../../../core/widgets/custom_filter_chip.dart';
import '../widgets/production_code_display.dart';
import '../widgets/production_shipping_modal.dart';
import '../widgets/qr_scanner_dialog.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({super.key});

  void _handleQrScanResult(BuildContext context, String qrValue) {
    // Parse QR value and navigate to detail page
    final int? produksiId = int.tryParse(qrValue);
    if (produksiId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code terdeteksi!'),
          duration: Duration(seconds: 1),
        ),
      );
      // Navigate to detail page
      context.push('/production/detail/$produksiId');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('QR Code tidak valid: $qrValue'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _openQrScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => QrScannerDialog(
        onScanResult: (qrValue) => _handleQrScanResult(context, qrValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProduksiViewModel>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Produksi',
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            tooltip: 'Scan QR Code',
            onPressed: () => _openQrScanner(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        hintText: 'Cari produksi...',
                        onChanged: (value) {
                          viewModel.setSearchQuery(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<ProduksiStatus?>(
                      icon: const Icon(Icons.filter_list),
                      tooltip: 'Filter by Status',
                      initialValue: viewModel.selectedStatus,
                      onSelected: (ProduksiStatus? result) {
                        viewModel.setSelectedStatus(result);
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<ProduksiStatus?>>[
                        const PopupMenuItem<ProduksiStatus?>(
                          value: null,
                          child: Text('Semua Status'),
                          
                        ),
                        ...ProduksiStatus.values.map((status) {
                          return PopupMenuItem<ProduksiStatus?>(
                            value: status,
                            child: Text(ProduksiStatusUtils.getStatusText(status)),
                          );
                        }).toList(),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: viewModel.selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          viewModel.setSelectedDate(picked);
                        }
                      },
                    ),
                  ],
                ),
                if (viewModel.selectedDate != null || viewModel.selectedStatus != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        if (viewModel.selectedStatus != null)
                          CustomFilterChip(
                            label: 'Status: ${ProduksiStatusUtils.getStatusText(viewModel.selectedStatus!)}',
                            onClear: () => viewModel.setSelectedStatus(null),
                            color: Colors.blue,
                          ),
                        if (viewModel.selectedDate != null)
                          const SizedBox(width: 8),
                        if (viewModel.selectedDate != null)
                          CustomFilterChip(
                            label: 'Tanggal: ${viewModel.selectedDate!.day}/${viewModel.selectedDate!.month}/${viewModel.selectedDate!.year}',
                            onClear: () => viewModel.setSelectedDate(null),
                            color: Colors.green,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.filteredProduksiList.isEmpty
                    ? const Center(child: Text('Belum ada data produksi'))
                    : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.filteredProduksiList.length,
                  itemBuilder: (context, index) {
                    final produksi = viewModel.filteredProduksiList[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: ProductionCodeDisplay(kode: produksi.kodeProduksi ?? 'N/A'),
                        title: Row(
                          children: [
                            Container(
                              width: 1,
                              height: 80,
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.only(right: 16),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        produksi.tujuanPengiriman.length > 17 
                                          ? '${produksi.tujuanPengiriman.substring(0, 17)}...'
                                          : produksi.tujuanPengiriman,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ProduksiStatusUtils.getStatusIcon(produksi.status),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  FutureBuilder<List<ItemProduksiData>>(
                                    // Mengambil item produksi berdasarkan ID produksi
                                    future: context.read<ProduksiViewModel>().fetchItemsForProduksiId(produksi.id),
                                    builder: (context, snapshot) {
                                      final dateWidget = Text(
                                          'Tanggal: ${produksi.tanggalPengiriman.day}/${produksi.tanggalPengiriman.month}/${produksi.tanggalPengiriman.year}',
                                          style: const TextStyle(fontSize: 14));

                                      Widget itemWidget;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        itemWidget = const Text('Memuat item...', style: TextStyle(fontSize: 14));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        itemWidget = const Text('Belum ada item.', style: TextStyle(fontSize: 14));
                                      } else {
                                        // Menggabungkan nama produk menjadi satu string
                                        final productNames = snapshot.data!
                                            .map((item) => item.namaProduk)
                                            .join(', ');
                                        itemWidget = Text('Item: $productNames',
                                            style: const TextStyle(fontSize: 14),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis);
                                      }

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          dateWidget,
                                          const SizedBox(height: 4),
                                          itemWidget,
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_horiz),
                          onSelected: (value) {
                            // Menggunakan read karena berada di dalam callback
                            if (value == 'edit') {
                              showShippingInfoModal(context, produksi: produksi);
                            } else if (value == 'delete') {
                              viewModel.deleteProduksi(produksi.id);
                            } else if (value == 'update_status') {
                              viewModel.updateProduksiStatus(produksi.id, ProduksiStatusUtils.getNextStatus(produksi.status));
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Hapus'),
                            ),
                            PopupMenuItem<String>(
                              value: 'update_status',
                              child: Row(
                                children: [
                                  ProduksiStatusUtils.getNextStatusIcon(produksi.status),
                                  const SizedBox(width: 8),
                                  Text(ProduksiStatusUtils.getNextStatusText(produksi.status)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          context.push('/production/detail/${produksi.id}');
                        },
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: () => showShippingInfoModal(context),
      ),
    );
  }
}
