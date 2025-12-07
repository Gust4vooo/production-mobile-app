import 'package:drift/drift.dart';
import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';

enum JenisBahan {
  bahanBaku,
  bahanPengemas,
}

// part 'kartu_stok_table.g.dart';

@DataClassName('KartuStokData')
class KartuStok extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nama => text()();
  TextColumn get gambarPath => text().nullable()();
  IntColumn get jumlah => integer()();
  TextColumn get satuan => text()();
  IntColumn get status => intEnum<StockStatus>().withDefault(const Constant(0))();
  IntColumn get jenis => intEnum<JenisBahan>().withDefault(const Constant(0))();
}
