import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/kartu_stok/data/repositories/kartu_stok_repository.dart';
import 'package:seger/features/kartu_stok/presentation/viewmodels/kartu_stok_view_model.dart';
import 'package:seger/features/produksi/data/repositories/produksi_repository.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';
import 'package:seger/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDatabase = AppDatabase.instance;

  // Inisialisasi repository
  final produksiRepository = ProduksiRepository(appDatabase);
  final kartuStokRepository = KartuStokRepository(appDatabase);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              ProduksiViewModel(produksiRepository)..fetchProduksi(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              KartuStokViewModel(kartuStokRepository)..fetchKartuStok(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'SEGER',
      theme: ThemeData(),
    );
  }
}
