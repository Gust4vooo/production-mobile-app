import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';
import 'package:seger/features/kartu_stok/presentation/viewmodels/kartu_stok_view_model.dart';

class DashboardStockSummary extends StatelessWidget {
  final KartuStokViewModel viewModel;

  const DashboardStockSummary({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final habisCount = viewModel.kartuStokList.where((item) => item.status == StockStatus.habis).length;
    final menipisCount = viewModel.kartuStokList.where((item) => item.status == StockStatus.menipis).length;
    final cukupCount = viewModel.kartuStokList.where((item) => item.status == StockStatus.cukupBanyak).length;
    final banyakCount = viewModel.kartuStokList.where((item) => item.status == StockStatus.masihBanyak).length;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 2.0,
      children: [
        _buildStatusCard(context, 'Habis', habisCount, Icons.error_outline, Colors.red.shade400),
        _buildStatusCard(context, 'Menipis', menipisCount, Icons.warning_amber_rounded, Colors.orange.shade400),
        _buildStatusCard(context, 'Cukup', cukupCount, Icons.inventory_2_outlined, Colors.yellow.shade700),
        _buildStatusCard(context, 'Banyak', banyakCount, Icons.check_circle_outline, Colors.green.shade400),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context, String title, int count, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.go('/stock?status=${title.toLowerCase()}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                    Text('$count Item', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
