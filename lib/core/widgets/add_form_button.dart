import 'package:flutter/material.dart';

class AddFormButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const AddFormButton({
    super.key,
    this.onPressed,
    this.text = 'Tambah', 
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 7, 117, 70),
        side: BorderSide(color: const Color.fromARGB(255, 7, 117, 70)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        minimumSize: const Size(0, 56),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}
