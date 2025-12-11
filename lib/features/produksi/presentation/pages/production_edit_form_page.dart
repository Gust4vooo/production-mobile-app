import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/core/widgets/save_button.dart';

import '../viewmodels/produksi_view_model.dart';
import '../widgets/production_appbar.dart';
import '../widgets/production_date_picker.dart';
import '../widgets/production_dropdown_field.dart';
import '../widgets/production_item_list.dart';
import '../widgets/production_quantity_field.dart';
import '../widgets/production_text_field.dart';
import '../widgets/production_textarea_field.dart';

class ProductionEditFormPage extends StatefulWidget {
  final String produksiId;

  const ProductionEditFormPage({super.key, required this.produksiId});

  @override
  State<ProductionEditFormPage> createState() => _ProductionEditFormPageState();
}

class _ProductionEditFormPageState extends State<ProductionEditFormPage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  late ProduksiViewModel _viewModel; 
  final _quantityController = TextEditingController(text: '1');

  final List<String> _sizes = [
    'Pilih ukuran',
    '500ml',
    '650ml',
    '1500ml',
    "Mangkok 500ml",
    "Cup 10oz",
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<ProduksiViewModel>(); 

    final id = int.parse(widget.produksiId);
    _viewModel.loadProduksiForEdit(id);

    _viewModel.addListener(_syncControllersWithViewModel);
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
      initialDate: _viewModel.formTanggalProduksi ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _viewModel.formTanggalProduksi = picked;
      _viewModel.notifyListeners();
    }
  }

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

  void _startEditingItem(ItemProduksiData item) {
    _viewModel.startEditingItem(item);
  }

  Future<void> _saveOrUpdateItem() async {
    final viewModel = context.read<ProduksiViewModel>();
    final itemNama = viewModel.formNamaProduk;
    final isUpdating = viewModel.editingItem != null;

    final success = await viewModel.saveOrUpdateItem();

    if (mounted && success) {
      final message = isUpdating
          ? 'Item "$itemNama" berhasil diperbarui'
          : 'Item "$itemNama" berhasil ditambahkan';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, tanggal, dan ukuran wajib diisi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProduksiViewModel>();
    final produksi = viewModel.produksiToEdit;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: const CustomProductionAppBar(title: 'Edit Produksi'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (produksi != null) ...[
              Text(
                'Tujuan Pengiriman: ${produksi.tujuanPengiriman}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Tanggal: ${produksi.tanggalPengiriman.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              const Text('Daftar Item', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ProductionItemList(
                items: viewModel.itemList,
                onEdit: _startEditingItem,
              ),
              const Divider(height: 32),
            ],

            Text(
              viewModel.editingItem != null ? 'Edit Item: ${viewModel.editingItem!.namaProduk}' : 'Tambah Item Baru',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomSaveButton(
                text: viewModel.editingItem != null ? 'Simpan Perubahan' : 'Tambah Item',
                onPressed: _saveOrUpdateItem,
              ),
              if (viewModel.editingItem != null) ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Batal Edit & Tambah Baru'),
                  onPressed: () => viewModel.clearFormState(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF077546),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF077546)),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  viewModel.clearEditingState();
                  context.go('/production');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF077546),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF077546)),
                ),
                child: const Text('Selesai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}