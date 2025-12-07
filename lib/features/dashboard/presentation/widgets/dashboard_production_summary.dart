import 'package:flutter/material.dart';
import 'package:seger/features/produksi/domain/produksi_status.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class DashboardProductionSummary extends StatelessWidget {
  final ProduksiViewModel viewModel;

  const DashboardProductionSummary({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final totalProduksi = viewModel.produksiList.length;
    final belumDiprosesCount = viewModel.produksiList.where((p) => p.status == ProduksiStatus.belumDiproses).length;
    final sedangDiprosesCount = viewModel.produksiList.where((p) => p.status == ProduksiStatus.sedangDiproses).length;
    final terkirimCount = viewModel.produksiList.where((p) => p.status == ProduksiStatus.terkirim).length;

    if (totalProduksi == 0) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const ListTile(title: Text('Belum ada data produksi.')),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressBar(
              'Belum Diproses',
              belumDiprosesCount,
              totalProduksi,
              Colors.grey,
            ),
            const SizedBox(height: 12),
            _buildProgressBar(
              'Sedang Diproses',
              sedangDiprosesCount,
              totalProduksi,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildProgressBar(
              'Terkirim',
              terkirimCount,
              totalProduksi,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, int count, int total, Color color) {
    final percentage = total > 0 ? count / total : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 4),
        Text(
          '${(percentage * 100).toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}
