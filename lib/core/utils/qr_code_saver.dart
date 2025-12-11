import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class QrCodeSaver {
  static const platform = MethodChannel('com.example.seger/qr_saver');

  static Future<bool> saveQrCodeToGallery(
    GlobalKey<State<StatefulWidget>> qrKey,
    String produksiId,
  ) async {
    try {
      // Request storage permission
      final status = await Permission.photos.request();

      if (status.isDenied) {
        return false;
      }

      // Capture QR code widget
      final boundary = qrKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        return false;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes == null) {
        return false;
      }

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final fileName = 'qr_code_produksi_$produksiId.png';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);

      // Write bytes to file
      await file.writeAsBytes(pngBytes);

      // Call native method to save to gallery
      try {
        final result = await platform.invokeMethod<bool>(
          'saveImageToGallery',
          {
            'imagePath': file.path,
            'albumName': 'Produksi QR Code',
            'fileName': fileName,
          },
        );
        return result ?? false;
      } on PlatformException catch (e) {
        print('Failed to save image: ${e.message}');
        return false;
      }
    } catch (e) {
      print('Error saving QR code: $e');
      return false;
    }
  }
}
