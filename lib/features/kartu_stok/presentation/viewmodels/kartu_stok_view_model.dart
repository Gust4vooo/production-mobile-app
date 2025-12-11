import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/kartu_stok/data/repositories/kartu_stok_repository.dart';
import 'package:drift/drift.dart';
import 'package:seger/features/kartu_stok/domain/stok_sort_option.dart';
import 'package:seger/core/database/tables/kartu_stok_table.dart';
// import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';

class KartuStokViewModel extends ChangeNotifier {
  final KartuStokRepository _repository;
  bool _isLoading = false;
  List<KartuStokData> _kartuStokList = [];
  KartuStokData? _editingItem;
  String _searchQuery = '';
  // Atur urutan default untuk menampilkan item yang habis lebih dulu.
  StockSortOption? _currentSortOption = StockSortOption.byStatusPlenty;

  String formNama = '';
  String _formSatuan = 'Pilih satuan';
  String get formSatuan => _formSatuan;
  set formSatuan(String value) {
    _formSatuan = value;
    notifyListeners();
  }

  JenisBahan _formJenis = JenisBahan.bahanBaku;
  JenisBahan get formJenis => _formJenis;
  set formJenis(JenisBahan value) {
    _formJenis = value;
    notifyListeners();
  }


  int _formJumlah = 0;
  int get formJumlah => _formJumlah;
  set formJumlah(int value) {
    _formJumlah = value;
    notifyListeners();
  }
  String? formGambarPath;

  final List<String> availableUnits = [
    'Pilih satuan',
    'kg',
    'gram',
    // 'liter',
    // 'ml',
    'pcs',
    // 'pack',
    // 'dus',
  ];

  bool get isLoading => _isLoading;
  List<KartuStokData> get kartuStokList => _kartuStokList;
  KartuStokData? get editingItem => _editingItem;
  StockSortOption? get currentSortOption => _currentSortOption;
  
  List<KartuStokData> get filteredKartuStokList => _searchQuery.isEmpty
    ? _kartuStokList
    : _kartuStokList.where((stok) =>
        stok.nama.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

  List<KartuStokData> get bahanBakuList => filteredKartuStokList
      .where((item) => item.jenis == JenisBahan.bahanBaku)
      .toList();

  List<KartuStokData> get bahanKemasList => filteredKartuStokList
      .where((item) => item.jenis == JenisBahan.bahanPengemas)
      .toList();

  KartuStokViewModel(this._repository) {
    fetchKartuStok();
  }

  Future<void> fetchKartuStok() async {
    _isLoading = true;
    notifyListeners();
    try {
      _kartuStokList = await _repository.getAllKartuStok();
      // Terapkan urutan default setelah data berhasil diambil.
      if (_currentSortOption != null) {
        _kartuStokList.sort((a, b) {
          if (_currentSortOption == StockSortOption.byStatusPlenty) {
            // Urutkan dari 'Masih Banyak' ke 'Habis'
            return a.status.index.compareTo(b.status.index);
          } else { // byStatusEmpty
            // Urutkan dari 'Habis' ke 'Masih Banyak'
            return b.status.index.compareTo(a.status.index);
          }
        });
      }
    } catch (e) {
      debugPrint("Gagal fetch data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveKartuStok() async {
    if (formNama.isEmpty || formSatuan == 'Pilih satuan') {
      return false;
    }

    bool success;
    if (_editingItem != null) {
      success = await updateKartuStok(
        id: _editingItem!.id,
        nama: formNama,
        gambarPath: formGambarPath,
        jumlah: formJumlah,
        satuan: formSatuan,
        jenis: _formJenis,
      );
    } else {
      success = await addKartuStok(
        nama: formNama,
        gambarPath: formGambarPath,
        jumlah: formJumlah,
        satuan: formSatuan,
        jenis: _formJenis,
      );
    }
    
    if (success) {
      clearFormState();
      return true;
    }
    
    return false;
  }

  Future<bool> addKartuStok({
    required String nama,
    String? gambarPath,
    required int jumlah,
    required String satuan,
    required JenisBahan jenis,
  }) async {
    try {
      await _repository.addKartuStok(
        nama: nama,
        gambarPath: gambarPath,
        jumlah: jumlah,
        satuan: satuan,
        jenis: jenis,
      );
      await fetchKartuStok();
      return true;
    } catch (e) {
      debugPrint("Gagal menambah stok: $e");
      return false;
    }
  }

  Future<bool> updateKartuStok({
    required int id,
    required String nama,
    String? gambarPath,
    required int jumlah,
    required String satuan,
    required JenisBahan jenis,
  }) async {
    try {
      final companion = KartuStokCompanion(
        id: Value(id),
        nama: Value(nama),
        gambarPath: Value(gambarPath),
        jumlah: Value(jumlah),
        satuan: Value(satuan),
        jenis: Value(jenis),
      );
      await _repository.updateKartuStok(companion);
      await fetchKartuStok();
      return true;
    } catch (e) {
      debugPrint("Gagal mengupdate stok: $e");
      return false;
    }
  }

  Future<void> deleteKartuStok(int id) async {
    await _repository.deleteKartuStok(id);
    await fetchKartuStok();
  }

  void startEditing(KartuStokData item) {
    _editingItem = item;
    formNama = item.nama;
    formSatuan = item.satuan;
    formJumlah = item.jumlah;
    formGambarPath = item.gambarPath;
    _formJenis = item.jenis;
    notifyListeners();
  }

  void clearFormState() {
    _editingItem = null;
    formNama = '';
    _formSatuan = 'Pilih satuan';
    _formJumlah = 0;
    formGambarPath = null;
    _formJenis = JenisBahan.bahanBaku;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      formGambarPath = image.path;
      notifyListeners();
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      formGambarPath = photo.path;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void sortItemsByStatus(StockSortOption? option) {
    _currentSortOption = option;
    if (option == null) {
      fetchKartuStok(); 
      return;
    }
    _kartuStokList.sort((a, b) {
      if (option == StockSortOption.byStatusPlenty) {
        return a.status.index.compareTo(b.status.index);
      } else {
        return b.status.index.compareTo(a.status.index);
      }
    });
    notifyListeners();
  }
}
