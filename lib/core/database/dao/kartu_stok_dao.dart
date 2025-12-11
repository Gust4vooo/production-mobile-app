import 'package:drift/drift.dart';
import '../app.database.dart';
import '../tables/kartu_stok_table.dart';

part 'kartu_stok_dao.g.dart';

@DriftAccessor(tables: [KartuStok])
class KartuStokDao extends DatabaseAccessor<AppDatabase> with _$KartuStokDaoMixin {
  KartuStokDao(AppDatabase db) : super(db);

  Future<int> insertKartuStok(KartuStokCompanion entry) =>
      into(kartuStok).insert(entry);

  Future<List<KartuStokData>> getAllKartuStok() =>
      select(kartuStok).get();

  Future<int> deleteKartuStok(int id) =>
      (delete(kartuStok)..where((tbl) => tbl.id.equals(id))).go();

  Future<bool> updateKartuStok(KartuStokCompanion entry) =>
      update(kartuStok).replace(entry);

  Future<KartuStokData?> getKartuStokById(int id) =>
      (select(kartuStok)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
}
