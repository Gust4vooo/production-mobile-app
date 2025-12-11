import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:seger/core/utils/qr_code_saver.dart';

class QrCodeDisplay extends StatefulWidget {
  final String produksiId;
  final GlobalKey<State<StatefulWidget>> qrKey;

  const QrCodeDisplay({
    super.key,
    required this.produksiId,
    required this.qrKey,
  });

  @override
  State<QrCodeDisplay> createState() => _QrCodeDisplayState();
}

class _QrCodeDisplayState extends State<QrCodeDisplay> {
  bool isSaving = false;

  Future<void> _downloadQrCode() async {
    if (!mounted) return;

    setState(() => isSaving = true);

    try {
      final success = await QrCodeSaver.saveQrCodeToGallery(
        widget.qrKey,
        widget.produksiId,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR Code berhasil disimpan ke galeri'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyimpan QR Code'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QR Code Produksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Center(
          child: RepaintBoundary(
            key: widget.qrKey,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: QrImageView(
                data: widget.produksiId,
                version: QrVersions.auto,
                size: 250.0,
                errorCorrectionLevel: QrErrorCorrectLevel.L,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: isSaving ? null : _downloadQrCode,
            icon: isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            label: Text(
              isSaving ? 'Menyimpan...' : 'Simpan ke Galeri',
            ),
          ),
        ),
      ],
    );
  }
}
