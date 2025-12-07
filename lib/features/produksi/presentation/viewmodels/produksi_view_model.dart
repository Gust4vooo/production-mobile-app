import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/produksi/data/repositories/produksi_repository.dart';
import 'package:seger/features/produksi/domain/produksi_status.dart';

enum SortOrder { ascending, descending }

class ProduksiViewModel extends ChangeNotifier {

  final ProduksiRepository _repository;
  bool _isLoading = false;
  bool _isSaving = false;
  List<ProduksiData> _produksiList = [];
  List<ItemProduksiData> _itemList = [];
  ProduksiData? _produksiToEdit;
  ItemProduksiData? _editingItem;
  String _searchQuery = '';
  SortOrder _sortOrder = SortOrder.ascending;

  SortOrder get sortOrder => _sortOrder;

  String formNamaProduk = '';
  String formUkuran = 'Pilih ukuran';
  int formJumlah = 1;
  String formDeskripsi = '';
  DateTime? formTanggalProduksi;
  String? _tempTujuanPengiriman;
  DateTime? _tempTanggalPengiriman;
  String? _tempKodeProduksi;
  final List<Map<String, dynamic>> _tempItems = [];

  final List<Map<String, dynamic>> _formStates = [{}]; 

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  List<ProduksiData> get produksiList => _produksiList;
  List<ItemProduksiData> get itemList => _itemList;
  ProduksiData? get produksiToEdit => _produksiToEdit;
  ItemProduksiData? get editingItem => _editingItem;
  String? get tempTujuanPengiriman => _tempTujuanPengiriman;
  DateTime? get tempTanggalPengiriman => _tempTanggalPengiriman;
  String? get tempKodeProduksi => _tempKodeProduksi;
  List<Map<String, dynamic>> get tempItems => _tempItems;
  List<ProduksiData> get filteredProduksiList {
    var filteredList = _searchQuery.isEmpty
        ? _produksiList
        : _produksiList.where((produksi) =>
            produksi.tujuanPengiriman.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (produksi.kodeProduksi?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)).toList();
    
    filteredList.sort((a, b) {
      int statusComparison = a.status.index.compareTo(b.status.index);
      if (_sortOrder == SortOrder.ascending) {
        return statusComparison;
      } else {
        return -statusComparison;
      }
    });

    return filteredList;
  }

  Map<String, dynamic> get currentForm => _formStates.isNotEmpty ? _formStates.first : {};

  ProduksiViewModel(this._repository) {
    fetchProduksi();
  }

  void toggleSortOrder() {
    _sortOrder = _sortOrder == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
    notifyListeners();
  }

  Future<void> fetchProduksi() async {
    _isLoading = true;
    notifyListeners();
    try {
      var listFromDb = await _repository.getAllProduksi();
      listFromDb.sort((a, b) => b.id.compareTo(a.id));
      _produksiList = listFromDb;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProduksiForEdit(int produksiId) async {
    var produksi = produksiList.where((p) => p.id == produksiId).firstOrNull;
    produksi ??= await _repository.getProduksiById(produksiId);
    if (produksi != null) {
      await startEditing(produksi);
    }
  }

  Future<bool> saveOrUpdateItem() async {
    if (formNamaProduk.isEmpty || formTanggalProduksi == null || formUkuran == 'Pilih ukuran') {
      return false;
    }

    if (_editingItem != null) {
      await updateItemProduksi(
        itemId: _editingItem!.id,
        namaProduk: formNamaProduk,
        ukuran: formUkuran,
        jumlah: formJumlah,
        deskripsi: formDeskripsi,
        tanggalProduksi: formTanggalProduksi!,
      );
    } else {
      if (_produksiToEdit != null) {
        await addItemProduksi(
          produksiId: _produksiToEdit!.id,
          namaProduk: formNamaProduk,
          ukuran: formUkuran,
          jumlah: formJumlah,
          deskripsi: formDeskripsi,
          tanggalProduksi: formTanggalProduksi!,
        );
      } else {
        addTempItem(
          namaProduk: formNamaProduk,
          ukuran: formUkuran,
          jumlah: formJumlah,
          deskripsi: formDeskripsi,
          tanggalProduksi: formTanggalProduksi!,
        );
      }
    }

    clearFormState();
    return true;
  }

  Future<void> saveAllToDatabase() async {
    if (_tempTujuanPengiriman == null || _tempTanggalPengiriman == null) return;

    _isSaving = true;
    notifyListeners();

    try {
      final produksiId = await _repository.addProduksi(
        tujuanPengiriman: _tempTujuanPengiriman!,
        tanggalPengiriman: _tempTanggalPengiriman!,
      );

      for (final item in _tempItems) {
        if (item['namaProduk'].isNotEmpty) {
          await _repository.addItemProduksi(
            namaProduk: item['namaProduk'],
            ukuran: item['ukuran'],
            jumlah: item['jumlah'],
            deskripsi: item['deskripsi'],
            tanggalProduksi: item['tanggalProduksi'],
            produksiId: produksiId,
          );
        }
      }

      clearTempData();
      await fetchProduksi();
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Map<String, dynamic> getCurrentForm() {
    return _formStates.isNotEmpty ? _formStates.first : {};
  }

  Future<void> startEditing(ProduksiData produksi) async {
    _produksiToEdit = produksi;
    _isLoading = true;
    notifyListeners();

    _itemList = await _repository.getItemsByProduksiId(produksi.id);

    _isLoading = false;
    notifyListeners();
  }

  void clearEditingState() {
    _produksiToEdit = null;
    _isLoading = false; 
    notifyListeners();
  }

  void startEditingItem(ItemProduksiData item) {
    _editingItem = item;
    formNamaProduk = item.namaProduk;
    formUkuran = item.ukuran;
    formJumlah = item.jumlah;
    formDeskripsi = item.deskripsi ?? '';
    formTanggalProduksi = item.tanggalProduksi;
    notifyListeners();
  }

  void clearFormState() {
    _editingItem = null;
    formNamaProduk = '';
    formUkuran = 'Pilih ukuran';
    formJumlah = 1;
    formDeskripsi = '';
    formTanggalProduksi = null;
    notifyListeners();
  }

  void setTempPengiriman({required String tujuan, required DateTime tanggal}) {
    _tempTujuanPengiriman = tujuan;
    _tempTanggalPengiriman = tanggal;
    notifyListeners();
  }

  void addTempItem({
    required String namaProduk,
    required String ukuran,
    required int jumlah,
    String? deskripsi,
    required DateTime tanggalProduksi,
  }) {
    _tempItems.add({
      'namaProduk': namaProduk,
      'ukuran': ukuran,
      'jumlah': jumlah,
      'deskripsi': deskripsi,
      'tanggalProduksi': tanggalProduksi,
    });
    notifyListeners();
  }

  void clearTempData() {
    _tempKodeProduksi = null;
    _tempTujuanPengiriman = null;
    _tempTanggalPengiriman = null;
    _tempItems.clear();
    _formStates.clear();
    _formStates.add({});
    clearFormState(); 
    notifyListeners();
  }

  void removeTempItem(int index) {
    if (index >= 0 && index < _tempItems.length) {
      _tempItems.removeAt(index);
      notifyListeners();
    }
  }

  // Metode CRUD & Interaksi Repository

  Future<void> updateProduksi(int id, String tujuan, DateTime tanggal) async {
    final companion = ProduksiCompanion(
      tujuanPengiriman: Value(tujuan),
      tanggalPengiriman: Value(tanggal),
    );
    await _repository.updateProduksiHeader(companion.copyWith(id: Value(id)));
    await fetchProduksi();
  }

  Future<void> deleteProduksi(int id) async {
    await _repository.deleteProduksi(id);
    await fetchProduksi();
  }

  // Metode baru untuk mengambil item untuk ID produksi tertentu tanpa mengubah state utama
  Future<List<ItemProduksiData>> fetchItemsForProduksiId(int produksiId) async {
    return await _repository.getItemsByProduksiId(produksiId);
  }

  Future<void> fetchItemsByProduksiId(int produksiId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _itemList = await _repository.getItemsByProduksiId(produksiId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItemProduksi({
    required String namaProduk,
    required String ukuran,
    required int jumlah,
    String? deskripsi,
    required DateTime tanggalProduksi,
    required int produksiId,
  }) async {
    await _repository.addItemProduksi(
      namaProduk: namaProduk,
      ukuran: ukuran,
      jumlah: jumlah,
      deskripsi: deskripsi,
      tanggalProduksi: tanggalProduksi,
      produksiId: produksiId,
    );
    await fetchItemsByProduksiId(produksiId);
  }

  Future<void> deleteItemProduksi(int id, int produksiId) async {
    await _repository.deleteItemProduksi(id);
    await fetchItemsByProduksiId(produksiId);
  }

  Future<void> updateItemProduksi({
    required int itemId,
    required String namaProduk,
    required String ukuran,
    required int jumlah,
    String? deskripsi,
    required DateTime tanggalProduksi,
  }) async {
    if (_produksiToEdit == null) return;

    final companion = ItemProduksiCompanion(
      namaProduk: Value(namaProduk),
      ukuran: Value(ukuran),
      jumlah: Value(jumlah),
      deskripsi: Value(deskripsi),
      tanggalProduksi: Value(tanggalProduksi),
      produksiId: Value(_produksiToEdit!.id),
    );
    await _repository.updateItemProduksi(companion.copyWith(id: Value(itemId)));
    await fetchItemsByProduksiId(_produksiToEdit!.id);
  }

  Future<void> updateProduksiStatus(int id, ProduksiStatus newStatus) async {
    try {
      await _repository.updateProduksiStatus(id, newStatus);
      await fetchProduksi();
    } catch (e) {
      rethrow;
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
