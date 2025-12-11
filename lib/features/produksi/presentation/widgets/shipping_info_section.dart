import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seger/core/database/app.database.dart';

class ShippingInfoSection extends StatelessWidget {
  final ProduksiData produksiHeader;

  const ShippingInfoSection({
    super.key,
    required this.produksiHeader,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pengiriman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildDetailItem(
          'Tujuan',
          produksiHeader.tujuanPengiriman,
        ),
        _buildDetailItem(
          'Tanggal Kirim',
          dateFormat.format(produksiHeader.tanggalPengiriman),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
