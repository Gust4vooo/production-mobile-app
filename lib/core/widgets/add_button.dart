import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? destinationPage;  

  const AddButton({
    super.key,
    required this.onPressed,
    this.destinationPage,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: destinationPage != null 
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationPage!),
              );
            }
          : onPressed,
      backgroundColor: const Color.fromARGB(255, 7, 117, 70),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}