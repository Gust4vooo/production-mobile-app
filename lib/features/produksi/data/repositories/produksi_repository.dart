import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/domain/produksi_status.dart';

class ProduksiRepository {
  final AppDatabase _db;

  ProduksiRepository(this._db);

  //Tambah data produksi dan kembalikan ID-nya
  Future<int> addProduksi({
    required String tujuanPengiriman,
    required DateTime tanggalPengiriman,
  }) async {
    return _db.transaction(() async {
      final initialCompanion = ProduksiCompanion.insert(
        tujuanPengiriman: tujuanPengiriman,
        tanggalPengiriman: tanggalPengiriman,
      );
      final newId = await _db.produksiDao.insertProduksi(initialCompanion);

      final date = DateTime.now();
      final formattedDate = DateFormat('ddMMyy').format(date);
      final newKodeProduksi = 'ET-$formattedDate-$newId';

      final updateCompanion = ProduksiCompanion(kodeProduksi: Value(newKodeProduksi));
      await (_db.update(_db.produksi)..where((tbl) => tbl.id.equals(newId)))
          .write(updateCompanion);

      return newId;
    });
  }

  /// Ambil semua data produksi
  Future<List<ProduksiData>> getAllProduksi() async {
    return await _db.produksiDao.getAllProduksi();
  }

  /// Ambil satu data produksi berdasarkan ID
  Future<ProduksiData?> getProduksiById(int id) async {
    return await _db.produksiDao.getProduksiById(id);
  }

  /// Hapus produksi
  Future<int> deleteProduksi(int id) async {
    return await _db.produksiDao.deleteProduksi(id);
  }

  // Update data header Produksi (tujuan & tanggal)
  Future<bool> updateProduksiHeader(ProduksiCompanion companion) async {
    return await _db.produksiDao.updateProduksi(companion);
  }

  // Update semua item produksi dalam satu transaksi
  Future<void> updateProduksiAndItems(List<ItemProduksiCompanion> items) async {
    return _db.transaction(() async {
      for (final item in items) {
        await _db.itemProduksiDao.updateItem(item);
      }
    });
  }
  
  // Tambah item produksi
  Future<int> addItemProduksi({
    required String namaProduk,
    required String ukuran,
    required int jumlah,
    String? deskripsi,
    required DateTime tanggalProduksi,
    required int produksiId,
  }) async {
    final item = ItemProduksiCompanion.insert(
      namaProduk: namaProduk,
      ukuran: ukuran,
      jumlah: jumlah,
      deskripsi: Value(deskripsi),
      tanggalProduksi: tanggalProduksi,
      produksiId: produksiId,
    );

    return await _db.itemProduksiDao.insertItem(item);
  }

  /// Ambil semua item berdasarkan produksiId
  Future<List<ItemProduksiData>> getItemsByProduksiId(int produksiId) async {
    return await _db.itemProduksiDao.getItemsByProduksiId(produksiId);
  }

  /// Hapus item produksi
  Future<int> deleteItemProduksi(int id) async {
    return await _db.itemProduksiDao.deleteItem(id);
  }

  // Update satu item produksi
  Future<bool> updateItemProduksi(ItemProduksiCompanion companion) async {
    return await _db.itemProduksiDao.updateItem(companion);
  }

  // Update status produksi
  Future<void> updateProduksiStatus(int id, ProduksiStatus status) async {
    await (_db.update(_db.produksi)..where((tbl) => tbl.id.equals(id))).write(
      ProduksiCompanion(status: Value(status)),
    );
  }
}
