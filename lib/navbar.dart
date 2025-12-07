import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trolley),
          label: 'Produksi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_sharp),
          label: 'Kartu Stok',
        ),
      ],
      currentIndex: _calculateSelectedIndex(context),
      onTap: (int idx) => _onItemTapped(idx, context),
      selectedItemColor: const Color.fromARGB(255, 7, 117, 70),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String path = GoRouterState.of(context).uri.path;
    if (path.startsWith('/dashboard')) {
      return 0;
    }
    if (path.startsWith('/production')) {
      return 1;
    }
    if (path.startsWith('/stock')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/dashboard');
        break;
      case 1:
        GoRouter.of(context).go('/production');
        break;
      case 2:
        GoRouter.of(context).go('/stock');
        break;
    }
  }
}
