import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onDelete;
  final VoidCallback onPickFromGallery;
  final VoidCallback onTakePhoto;

  const ImagePickerWidget({
    super.key,
    required this.imagePath,
    required this.onDelete,
    required this.onPickFromGallery,
    required this.onTakePhoto,
  });

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Hapus Gambar'),
        content: const Text('Apakah Anda yakin ingin menghapus gambar ini?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          TextButton(
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: imagePath == null
              ? const Text('Tidak ada gambar dipilih.')
              : Image.file(File(imagePath!), height: 60),
        ),
        IconButton(
          icon: const Icon(Icons.delete_forever, color: Colors.red),
          onPressed: () async {
            final confirmed = await _showDeleteConfirmation(context);
            if (confirmed == true && context.mounted) {
              onDelete();
            }
          },
          tooltip: 'Hapus Gambar',
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: onPickFromGallery,
          tooltip: 'Pilih dari Galeri',
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: onTakePhoto,
          tooltip: 'Ambil Foto',
        ),
      ],
    );
  }
}
