import 'package:drift/drift.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/core/database/tables/kartu_stok_table.dart';
import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';

class KartuStokRepository {
  final AppDatabase _db;

  KartuStokRepository(this._db);

  /// Tambah data kartu stok dan kembalikan ID-nya
  Future<int> addKartuStok({
    required String nama,
    String? gambarPath,
    required int jumlah,
    required String satuan,
    required JenisBahan jenis,
  }) async {
    final status = KartuStokUtils.computeStatus(jumlah, satuan);
    final kartuStok = KartuStokCompanion.insert(
      nama: nama,
      gambarPath: Value(gambarPath),
      jumlah: jumlah,
      satuan: satuan,
      status: Value(status),
      jenis: Value(jenis),
    );

    return await _db.kartuStokDao.insertKartuStok(kartuStok);
  }

  /// Ambil semua data kartu stok
  Future<List<KartuStokData>> getAllKartuStok() async {
    return await _db.kartuStokDao.getAllKartuStok();
  }

  /// Ambil satu data kartu stok berdasarkan ID
  Future<KartuStokData?> getKartuStokById(int id) async {
    return await _db.kartuStokDao.getKartuStokById(id);
  }

  /// Hapus kartu stok
  Future<int> deleteKartuStok(int id) async {
    return await _db.kartuStokDao.deleteKartuStok(id);
  }

  /// Update data kartu stok
  Future<bool> updateKartuStok(KartuStokCompanion companion) async {
    if (companion.jumlah.present || companion.satuan.present) {
      final existing = await getKartuStokById(companion.id.value);
      if (existing != null) {
        final newJumlah = companion.jumlah.present ? companion.jumlah.value : existing.jumlah;
        final newSatuan = companion.satuan.present ? companion.satuan.value : existing.satuan;
        final newStatus = KartuStokUtils.computeStatus(newJumlah, newSatuan);
        companion = companion.copyWith(status: Value(newStatus));
      }
    }
    return await _db.kartuStokDao.updateKartuStok(companion);
  }
}
