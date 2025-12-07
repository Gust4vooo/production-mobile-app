import 'package:drift/drift.dart';
import 'produksi_table.dart';

@DataClassName('ItemProduksiData')
class ItemProduksi extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaProduk => text().named('nama_produk')();
  TextColumn get ukuran => text()();
  IntColumn get jumlah => integer()();
  TextColumn get deskripsi => text().nullable()();
  DateTimeColumn get tanggalProduksi => dateTime().named('tanggal_produksi')();
  IntColumn get produksiId =>
      integer().named('produksi_id').references(Produksi, #id, onDelete: KeyAction.cascade)();
}
