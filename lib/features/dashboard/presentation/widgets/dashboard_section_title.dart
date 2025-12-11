import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final String? route;

  const DashboardSectionTitle({super.key, required this.title, this.route});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        if (route != null)
          TextButton(
            onPressed: () => context.go(route!),
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 7, 117, 70),
            ),
            child: const Text('Lihat Semua'),
          ),
      ],
    );
  }
}
