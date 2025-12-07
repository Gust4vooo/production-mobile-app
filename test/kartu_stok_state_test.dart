import 'package:flutter_test/flutter_test.dart';
import 'package:seger/core/database/app.database.dart'; // Diperlukan untuk tipe data KartuStokData
import 'package:seger/features/kartu_stok/data/repositories/kartu_stok_repository.dart';
import 'package:seger/features/kartu_stok/presentation/viewmodels/kartu_stok_view_model.dart';

class FakeKartuStokRepository extends Fake implements KartuStokRepository {
  @override
  Future<List<KartuStokData>> getAllKartuStok() async => []; 
  
  @override
  Future<int> addKartuStok({required String nama, String? gambarPath, required int jumlah, required String satuan}) async {
    return 1;
  }
}

void main() {
  final fakeRepo = FakeKartuStokRepository();

  test('saveKartuStok bernilai TRUE jika Nama dan Satuan terisi', () async {
    final vm = KartuStokViewModel(fakeRepo);
    
    vm
      ..formNama = 'Tepung Terigu'
      ..formSatuan = 'kg'; 

    final resultSuccess = await vm.saveKartuStok();
    expect(resultSuccess, isTrue);
  });

  test('saveKartuStok bernilai FALSE jika Nama atau Satuan kosong', () async {
    final vm = KartuStokViewModel(fakeRepo);
    
    vm
      ..formNama = 'Tepung Terigu'
      ..formSatuan = 'Pilih satuan';
      
    final resultFail1 = await vm.saveKartuStok();
    expect(resultFail1, isFalse);

    vm
      ..formNama = '' 
      ..formSatuan = 'kg';
      
    final resultFail2 = await vm.saveKartuStok();
    expect(resultFail2, isFalse);
  });
}