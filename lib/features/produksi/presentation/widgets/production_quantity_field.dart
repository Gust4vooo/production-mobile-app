import 'package:flutter/material.dart';

class ProductionQuantityField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final ValueChanged<String>? onChanged;

  const ProductionQuantityField({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.onRemove,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color.fromARGB(255, 7, 117, 70)),
                onPressed: onRemove,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: onChanged,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Color.fromARGB(255, 7, 117, 70)),
                onPressed: onAdd,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
