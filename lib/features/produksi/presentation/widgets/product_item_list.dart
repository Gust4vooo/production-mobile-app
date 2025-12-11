import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seger/core/database/app.database.dart';

class ProductItemList extends StatelessWidget {
  final List<ItemProduksiData> items;

  const ProductItemList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Item Produksi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const Center(
            child: Text('Belum ada item produksi untuk pengiriman ini.'),
          )
        else
          ...items.map((item) => _buildItemCard(item)),
      ],
    );
  }

  Widget _buildItemCard(ItemProduksiData item) {
    final dateFormat = DateFormat('d MMMM yyyy');

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.namaProduk,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailItem('Jumlah', '${item.jumlah} pcs'),
            _buildDetailItem('Ukuran', item.ukuran),
            _buildDetailItem('Tgl. Produksi', dateFormat.format(item.tanggalProduksi)),
            if (item.deskripsi != null && item.deskripsi!.isNotEmpty)
              _buildDetailItem('Catatan', item.deskripsi!),
          ],
        ),
      ),
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
