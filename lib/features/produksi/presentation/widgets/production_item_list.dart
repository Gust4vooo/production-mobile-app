import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class ProductionItemList extends StatelessWidget {
  final List<ItemProduksiData> items;
  final Function(ItemProduksiData) onEdit;

  const ProductionItemList({
    super.key,
    required this.items,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProduksiViewModel>();

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: Text('Belum ada item produksi.')),
      );
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
            title: Text(item.namaProduk),
            subtitle: Text('${item.ukuran} - Jumlah: ${item.jumlah} pcs'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Color.fromARGB(255, 7, 117, 70),),
                  onPressed: () => onEdit(item),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent), 
                  onPressed: () async => await viewModel.deleteItemProduksi(item.id, item.produksiId),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}