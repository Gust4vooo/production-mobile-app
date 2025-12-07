import 'package:drift/drift.dart';
import '../app.database.dart';
import '../tables/produksi_table.dart';

part 'produksi_dao.g.dart';

@DriftAccessor(tables: [Produksi])
class ProduksiDao extends DatabaseAccessor<AppDatabase> with _$ProduksiDaoMixin {
  ProduksiDao(AppDatabase db) : super(db);

  Future<int> insertProduksi(ProduksiCompanion entry) =>
      into(produksi).insert(entry);

  Future<List<ProduksiData>> getAllProduksi() =>
      select(produksi).get();

  Future<int> deleteProduksi(int id) =>
      (delete(produksi)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> updateProduksi(ProduksiCompanion entry) =>
      update(produksi).replace(entry);

  Future<ProduksiData?> getProduksiById(int id) =>
      (select(produksi)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
}
