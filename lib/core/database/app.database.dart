import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dao/produksi_dao.dart';
import 'dao/item_produksi_dao.dart';
import 'dao/kartu_stok_dao.dart';
import 'tables/produksi_table.dart';
import 'tables/item_produksi_table.dart';
import 'tables/kartu_stok_table.dart';
import 'package:seger/features/produksi/domain/produksi_status.dart';
import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';

part 'app.database.g.dart';

@DriftDatabase(
  tables: [Produksi, ItemProduksi, KartuStok], 
  daos: [ProduksiDao, ItemProduksiDao, KartuStokDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal([QueryExecutor? executor]) : super(executor ?? _openConnection());

  AppDatabase.inMemory() : super(NativeDatabase.memory());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 2; 

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'seger.db'));

      final database = NativeDatabase(
        file,
        setup: (db) {
          db.execute('PRAGMA foreign_keys = ON;');
        },
      );

      return database;
    });
  }
}
