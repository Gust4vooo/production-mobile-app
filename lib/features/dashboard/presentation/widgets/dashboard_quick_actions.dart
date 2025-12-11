import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => context.go('/production/add'),
          icon: const Icon(Icons.add),
          label: const Text('Tambah Produksi'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => context.go('/stock?action=add'),
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Tambah Stok'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
