import 'package:flutter/material.dart';
import '../../../../core/widgets/save_button.dart';
import '../../../../core/database/tables/kartu_stok_table.dart';
import '../viewmodels/kartu_stok_view_model.dart';
import 'quantity_stepper.dart';
import 'image_picker_widget.dart';
import 'delete_confirmation_dialog.dart';

class StockFormModal extends StatefulWidget {
  final KartuStokViewModel viewModel;

  const StockFormModal({super.key, required this.viewModel});

  @override
  State<StockFormModal> createState() => _StockFormModalState();
}

class _StockFormModalState extends State<StockFormModal> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.viewModel.formNama);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.editingItem == null ? 'Tambah Bahan Baku' : 'Edit Bahan Baku',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Input Nama Bahan
            TextField(
              controller: _nameController,
              onChanged: (value) => viewModel.formNama = value,
              decoration: const InputDecoration(
                labelText: 'Nama Bahan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown Satuan
            DropdownButtonFormField<String>(
              initialValue: viewModel.formSatuan,
              decoration: const InputDecoration(
                labelText: 'Satuan',
                border: OutlineInputBorder(),
              ),
              items: viewModel.availableUnits.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => viewModel.formSatuan = newValue);
                }
              },
            ),
            const SizedBox(height: 16),

            // Dropdown Jenis Bahan
            DropdownButtonFormField<JenisBahan>(
              value: viewModel.formJenis,
              decoration: const InputDecoration(
                labelText: 'Jenis Bahan',
                border: OutlineInputBorder(),
              ),
              items: JenisBahan.values.map((JenisBahan jenis) {
                return DropdownMenuItem<JenisBahan>(
                  value: jenis,
                  child: Text(
                      jenis == JenisBahan.bahanBaku ? 'Bahan Baku' : 'Bahan Pengemas'),
                );
              }).toList(),
              onChanged: (JenisBahan? newValue) {
                if (newValue != null) {
                  viewModel.formJenis = newValue;
                }
              },
            ),
            const SizedBox(height: 16),

            // Input Jumlah Stok
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Jumlah Stok', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                QuantityStepper(
                  initialValue: viewModel.formJumlah,
                  onChanged: (value) => viewModel.formJumlah = value,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Input Gambar
            ImagePickerWidget(
              imagePath: viewModel.formGambarPath,
              onDelete: () {
                viewModel.formGambarPath = null;
                if (mounted) setState(() {});
              },
              onPickFromGallery: () async {
                await viewModel.pickImage();
                if (mounted) setState(() {});
              },
              onTakePhoto: () async {
                await viewModel.takePhoto();
                if (mounted) setState(() {});
              },
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            CustomSaveButton(
              onPressed: () async {
                final success = await viewModel.saveKartuStok();
                if (!mounted) return;
                if (success) {
                  Navigator.pop(context); // Tutup modal jika berhasil
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal menyimpan! Pastikan semua kolom terisi.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
            // Tampilkan tombol hapus hanya jika dalam mode edit
            if (viewModel.editingItem != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Bahan Baku'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
                      ),
                    ),
                    onPressed: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (BuildContext dialogContext) => DeleteConfirmationDialog(
                          itemName: viewModel.editingItem!.nama,
                          onConfirm: () async {
                            await viewModel.deleteKartuStok(viewModel.editingItem!.id);
                            if (!mounted) return;
                            Navigator.pop(context); 
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
