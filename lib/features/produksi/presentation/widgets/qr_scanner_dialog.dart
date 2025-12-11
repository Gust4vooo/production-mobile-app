import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrScannerDialog extends StatefulWidget {
  final Function(String) onScanResult;

  const QrScannerDialog({
    super.key,
    required this.onScanResult,
  });

  @override
  State<QrScannerDialog> createState() => _QrScannerDialogState();
}

class _QrScannerDialogState extends State<QrScannerDialog> {
  late MobileScannerController controller;
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionTimeoutMs: 1000,
      returnImage: false,
    );
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied) {
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission diperlukan')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBar(
              title: const Text('Scan QR Code'),
              centerTitle: true,
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  if (!isScanning) return;

                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String qrValue = barcodes.first.rawValue ?? '';
                    if (qrValue.isNotEmpty) {
                      setState(() => isScanning = false);
                      widget.onScanResult(qrValue);
                      Navigator.pop(context);
                    }
                  }
                },
                errorBuilder: (context, error, child) {
                  return Center(
                    child: Text(
                      'Kamera tidak dapat diakses',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.flash_off),
                    onPressed: () => controller.toggleTorch(),
                    tooltip: 'Toggle Flash',
                  ),
                  IconButton(
                    icon: const Icon(Icons.flip_camera_android),
                    onPressed: () => controller.switchCamera(),
                    tooltip: 'Switch Camera',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
