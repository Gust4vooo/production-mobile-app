import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class TempItemList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const TempItemList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProduksiViewModel>();

    if (items.isEmpty) {
      return const SizedBox.shrink(); 
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(item['namaProduk']),
            subtitle: Text('${item['ukuran']} - Jumlah: ${item['jumlah']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => viewModel.removeTempItem(index),
            ),
          ),
        );
      },
    );
  }
}