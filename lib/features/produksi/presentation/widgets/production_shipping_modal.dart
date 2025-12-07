import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app.database.dart';
import '../../../../core/widgets/add_form_button.dart';
import '../viewmodels/produksi_view_model.dart';
import 'production_text_field.dart';
import 'production_date_picker.dart';

void showShippingInfoModal(BuildContext context, {ProduksiData? produksi}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ShippingInfoModal(produksi: produksi);
    },
  );
}

class ShippingInfoModal extends StatefulWidget {
  final ProduksiData? produksi;
  const ShippingInfoModal({super.key, this.produksi});

  @override
  State<ShippingInfoModal> createState() => _ShippingInfoModalState();
}

class _ShippingInfoModalState extends State<ShippingInfoModal> {
  final _destinationController = TextEditingController();
  DateTime? _shippingDate;
  bool get _isEditMode => widget.produksi != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _destinationController.text = widget.produksi!.tujuanPengiriman;
      _shippingDate = widget.produksi!.tanggalPengiriman;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _shippingDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _shippingDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProduksiViewModel>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _isEditMode ? 'Edit Informasi Pengiriman' : 'Informasi Pengiriman',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ProductionTextField(
            label: 'Tujuan Pengiriman',
            hint: 'Alamat atau nama pelanggan',
            controller: _destinationController,
          ),
          const SizedBox(height: 16),
          ProductionDatePicker(
            label: 'Tanggal Pengiriman',
            selectedDate: _shippingDate,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: 24),
          AddFormButton(
            text: _isEditMode ? 'Simpan Perubahan' : 'Tambah Produksi',
            onPressed: () {
              if (_destinationController.text.isNotEmpty && _shippingDate != null) {
                if (_isEditMode) {
                  viewModel.updateProduksi(
                    widget.produksi!.id,
                    _destinationController.text,
                    _shippingDate!,
                  );
                  Navigator.pop(context);
                } else {
                  viewModel.setTempPengiriman(
                    tujuan: _destinationController.text,
                    tanggal: _shippingDate!,
                  );
                  Navigator.pop(context);
                  context.push('/production/add');
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Lengkapi Informasi pengiriman terlebih dahulu'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
          if (_isEditMode) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 7, 117, 70), 
              ),
              onPressed: () async {
                await viewModel.startEditing(widget.produksi!);
                if (mounted) {
                  Navigator.pop(context); 
                  context.push('/production/edit/${widget.produksi!.id}');
                }
              },
              child: const Text('Lanjut ke Form'),
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
