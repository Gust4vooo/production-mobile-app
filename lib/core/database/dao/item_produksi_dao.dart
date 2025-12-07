import 'package:drift/drift.dart';
import '../app.database.dart';
import '../tables/item_produksi_table.dart';

part 'item_produksi_dao.g.dart';

@DriftAccessor(tables: [ItemProduksi])
class ItemProduksiDao extends DatabaseAccessor<AppDatabase> with _$ItemProduksiDaoMixin {
  ItemProduksiDao(AppDatabase db) : super(db);

  Future<int> insertItem(ItemProduksiCompanion entry) =>
      into(itemProduksi).insert(entry);

  Future<List<ItemProduksiData>> getItemsByProduksiId(int produksiId) =>
      (select(itemProduksi)..where((tbl) => tbl.produksiId.equals(produksiId))).get();

  Future<int> deleteItem(int id) =>
      (delete(itemProduksi)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> updateItem(ItemProduksiCompanion entry) =>
      update(itemProduksi).replace(entry);
}
