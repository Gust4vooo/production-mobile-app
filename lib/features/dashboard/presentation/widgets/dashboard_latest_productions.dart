import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class DashboardLatestProductions extends StatelessWidget {
  final ProduksiViewModel viewModel;

  const DashboardLatestProductions({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: viewModel.produksiList.isEmpty
          ? const ListTile(title: Text('Belum ada produksi terbaru.'))
          : Column(
              children: viewModel.produksiList.take(3).map((produksi) {
                return ListTile(
                  leading: const Icon(Icons.local_shipping_outlined, color: Colors.blueGrey),
                  title: Text('Pengiriman ke ${produksi.tujuanPengiriman}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Tanggal: ${produksi.tanggalPengiriman.day}/${produksi.tanggalPengiriman.month}/${produksi.tanggalPengiriman.year}'),
                  onTap: () => context.go('/production/detail/${produksi.id}'),
                );
              }).toList(),
            ),
    );
  }
}
