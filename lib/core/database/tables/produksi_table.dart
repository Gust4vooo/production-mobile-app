import 'package:drift/drift.dart';
import 'package:seger/features/produksi/domain/produksi_status.dart';

@DataClassName('ProduksiData')
class Produksi extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get kodeProduksi => text().named('kode_produksi').unique().nullable()();
  TextColumn get tujuanPengiriman => text().named('tujuan_pengiriman')();
  DateTimeColumn get tanggalPengiriman => dateTime().named('tanggal_pengiriman')();
  IntColumn get status => intEnum<ProduksiStatus>().named('status').withDefault(const Constant(0))();
}
