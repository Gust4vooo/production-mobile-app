import 'package:flutter/material.dart';
import 'produksi_status.dart';

class ProduksiStatusUtils {
  static Color getStatusColor(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return Colors.grey;
      case ProduksiStatus.sedangDiproses:
        return Colors.orange;
      case ProduksiStatus.terkirim:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String getStatusText(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return 'Belum Diproses';
      case ProduksiStatus.sedangDiproses:
        return 'Sedang Diproses';
      case ProduksiStatus.terkirim:
        return 'Terkirim';
      default:
        return 'Unknown';
    }
  }

  static String getNextStatusText(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return 'Mulai proses';
      case ProduksiStatus.sedangDiproses:
        return 'Kirim produk';
      case ProduksiStatus.terkirim:
        return 'Batalkan produksi';
      default:
        return 'Update status';
    }
  }

  static ProduksiStatus getNextStatus(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return ProduksiStatus.sedangDiproses;
      case ProduksiStatus.sedangDiproses:
        return ProduksiStatus.terkirim;
      case ProduksiStatus.terkirim:
        return ProduksiStatus.belumDiproses;
      default:
        return ProduksiStatus.belumDiproses;
    }
  }

  static Widget getStatusIcon(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 10,
          ),
        );
      case ProduksiStatus.sedangDiproses:
        return const Icon(
          Icons.access_time,
          color: Colors.orange,
          size: 16,
        );
      case ProduksiStatus.terkirim:
        return const Icon(
          Icons.local_shipping,
          color: Colors.green,
          size: 16,
        );
      default:
        return const Icon(
          Icons.help,
          color: Colors.grey,
          size: 24,
        );
    }
  }

  static Widget getNextStatusIcon(ProduksiStatus status) {
    switch (status) {
      case ProduksiStatus.belumDiproses:
        return const Icon(
          Icons.access_time,
          color: Colors.orange,
          size: 16,
        );
      case ProduksiStatus.sedangDiproses:
        return const Icon(
          Icons.local_shipping,
          color: Colors.green,
          size: 16,
        );
      case ProduksiStatus.terkirim:
        return Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 10,
          ),
        );
      default:
        return const Icon(
          Icons.help,
          color: Colors.grey,
          size: 16,
        );
    }
  }
}
