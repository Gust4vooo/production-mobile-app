import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onClear;
  final Color color;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.onClear,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onClear,
            child: const Icon(Icons.clear, size: 14),
          )
        ],
      ),
    );
  }
}
