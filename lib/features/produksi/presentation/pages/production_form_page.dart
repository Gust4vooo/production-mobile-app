import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seger/core/widgets/save_button.dart';
import 'package:provider/provider.dart';
import '../viewmodels/produksi_view_model.dart';
import 'package:seger/core/widgets/add_form_button.dart';
import '../widgets/production_appbar.dart';
import '../widgets/production_text_field.dart';
import '../widgets/production_textarea_field.dart';
import '../widgets/production_date_picker.dart';
import '../widgets/production_dropdown_field.dart';
import '../widgets/production_quantity_field.dart';
import '../widgets/temp_item_list.dart';

class ProductionFormPage extends StatefulWidget {

  const ProductionFormPage({super.key});
  @override
  State<ProductionFormPage> createState() => _ProductionFormPageState();
}

class _ProductionFormPageState extends State<ProductionFormPage> {
  final _nameController = TextEditingController();
  late ProduksiViewModel _viewModel;
  final _descController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  final List<String> _sizes = [
    'Pilih ukuran',
    '500ml',
    '650ml',
    '1500ml',
    "Mangkok 500ml",
    "Cup 10oz"
  ];

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _viewModel = context.read<ProduksiViewModel>();
    _viewModel.addListener(_syncControllersWithViewModel);

    final data = _viewModel.getCurrentForm();
    _nameController.text = data['namaProduk'] ?? '';
    _descController.text = data['deskripsi'] ?? '';
    _quantityController.text = (data['jumlah']?.toString() ?? '1');
    _viewModel.formUkuran = data['ukuran'] ?? 'Pilih ukuran';
    _viewModel.formTanggalProduksi = data['tanggalProduksi'];
  });
}

  Future<void> saveForm() async {
    final viewModel = context.read<ProduksiViewModel>();

    if (_nameController.text.isEmpty && _descController.text.isEmpty) return;

    if (_nameController.text.isEmpty ||
        viewModel.formTanggalProduksi == null ||
        viewModel.formUkuran == 'Pilih ukuran') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, tanggal, dan ukuran wajib diisi')),
      );
      return;
    }

    viewModel.addTempItem(
      namaProduk: _nameController.text,
      ukuran: viewModel.formUkuran,
      jumlah: int.tryParse(_quantityController.text) ?? 1,
      deskripsi: _descController.text,
      tanggalProduksi: viewModel.formTanggalProduksi!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item "${_nameController.text}" berhasil ditambahkan')),
    );

    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _descController.clear();
    _quantityController.text = '1';
    _viewModel..formUkuran = 'Pilih ukuran'
      ..formTanggalProduksi = null
      ..formJumlah = 1
      ..formDeskripsi = ''
      ..formNamaProduk = ''
      ..notifyListeners();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_syncControllersWithViewModel); 
    _nameController.dispose();
    _descController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _viewModel.formTanggalProduksi = picked;
      _viewModel.notifyListeners();
    }
  }

  // Fungsi untuk sinkronisasi UI dengan ViewModel
  void _syncControllersWithViewModel() {
    if (_nameController.text != _viewModel.formNamaProduk) {
      _nameController.text = _viewModel.formNamaProduk;
    }
    if (_descController.text != _viewModel.formDeskripsi) {
      _descController.text = _viewModel.formDeskripsi;
    }
    if (_quantityController.text != _viewModel.formJumlah.toString()) {
      _quantityController.text = _viewModel.formJumlah.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProduksiViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: const CustomProductionAppBar(title: 'Tambah Produksi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.tempItems.isNotEmpty) ...[
              const Text('Item yang Ditambahkan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TempItemList(items: viewModel.tempItems),
              const Divider(height: 32),
            ],

            // Form input item baru (bisa dipakai di dua mode)
            const Text('Tambah Item Baru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ProductionTextField(
              label: 'Nama Produk',
              hint: 'Contoh: Tape Singkong',
              controller: _nameController,
              onChanged: (value) => viewModel.formNamaProduk = value,
            ),
            const SizedBox(height: 16),
            ProductionTextAreaField(
              label: 'Deskripsi',
              hint: 'Deskripsi atau catatan singkat',
              controller: _descController,
              onChanged: (value) => viewModel.formDeskripsi = value,
            ),
            const SizedBox(height: 16),
            ProductionDatePicker(
              label: 'Tanggal Produksi',
              selectedDate: viewModel.formTanggalProduksi,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProductionDropdownField(
                    label: 'Ukuran',
                    selectedValue: viewModel.formUkuran,
                    items: _sizes,
                    onChanged: (value) {
                      viewModel.formUkuran = value ?? 'Pilih ukuran';
                      viewModel.notifyListeners();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ProductionQuantityField(
                    controller: _quantityController,
                    onChanged: (value) {
                      viewModel.formJumlah = int.tryParse(value) ?? 1;
                    },
                    onAdd: () {
                      int current = int.tryParse(_quantityController.text) ?? 0;
                      viewModel.formJumlah = current + 1;
                      viewModel.notifyListeners();
                    },
                    onRemove: () {
                      int current = int.tryParse(_quantityController.text) ?? 1;
                      if (current > 1) {
                        viewModel.formJumlah = current - 1;
                        viewModel.notifyListeners();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CustomSaveButton(
                  text: 'Simpan Semua',
                  onPressed: () async {
                    await saveForm();
                    await viewModel.saveAllToDatabase();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Produksi baru berhasil disimpan'),
                        ),
                      );
                      context.go('/production');
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: AddFormButton(
                  text: '+ Item',
                  onPressed: () {
                    saveForm();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}