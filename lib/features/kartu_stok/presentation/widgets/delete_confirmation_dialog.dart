import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konfirmasi Hapus'),
      content: Text('Apakah Anda yakin ingin menghapus "$itemName"?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Batal'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm();
          },
        ),
      ],
    );
  }
}
