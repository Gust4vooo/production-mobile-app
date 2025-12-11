import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/data/repositories/produksi_repository.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';
import 'package:seger/features/produksi/presentation/widgets/production_shipping_modal.dart';

void main() {
  testWidgets(
    'menampilkan snackbar jika tombol Tambah Produksi ditekan tetapi field kosong',
    (WidgetTester tester) async {

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<AppDatabase>(
              create: (_) => AppDatabase.inMemory(),
            ),

            Provider<ProduksiRepository>(
              create: (context) => ProduksiRepository(
                context.read<AppDatabase>(),
              ),
            ),

            ChangeNotifierProvider<ProduksiViewModel>(
              create: (context) => ProduksiViewModel(
                context.read<ProduksiRepository>(),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: ShippingInfoModal(),
            ),
          ),
        ),
      );

      await tester.pump();

      final btnTambah = find.text('Tambah Produksi');
      expect(btnTambah, findsOneWidget);

      await tester.tap(btnTambah);
      await tester.pump();
      
      expect(
        find.text('Lengkapi Informasi pengiriman terlebih dahulu'),
        findsOneWidget,
      );
    },
  );
}
