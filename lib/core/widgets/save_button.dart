import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final double borderRadius;
  final double height;

  const CustomSaveButton({
    super.key,
    required this.onPressed,
    this.text = 'Simpan',
    this.backgroundColor = const Color.fromARGB(255, 7, 117, 70),
    this.borderRadius = 8.0,
    this.height = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: Size.fromHeight(height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}