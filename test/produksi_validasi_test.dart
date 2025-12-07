import 'package:flutter_test/flutter_test.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/data/repositories/produksi_repository.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class FakeProduksiRepository extends Fake implements ProduksiRepository {
  @override
  Future<List<ProduksiData>> getAllProduksi() async => []; 
}

void main() {
  final fakeRepo = FakeProduksiRepository();
  test('saveOrUpdateItem bernilai TRUE jika semua field wajib terisi', () async {
    final vm = ProduksiViewModel(fakeRepo);
    
    vm
      ..formNamaProduk = 'Produk Uji Sukses'
      ..formUkuran = '500ml' 
      ..formTanggalProduksi = DateTime.now();
      
    final resultSuccess = await vm.saveOrUpdateItem();
    expect(resultSuccess, isTrue);
  });

  test('saveOrUpdateItem bernilai FALSE jika Nama Produk kosong', () async {
    final vm = ProduksiViewModel(fakeRepo);
    
    vm
      ..formNamaProduk = '' 
      ..formUkuran = '500ml' 
      ..formTanggalProduksi = DateTime.now();

    final resultFail = await vm.saveOrUpdateItem();
    expect(resultFail, isFalse);
  });
}