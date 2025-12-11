import 'package:flutter/material.dart';

enum StockStatus {
  habis,
  menipis,
  cukupBanyak,
  masihBanyak,
}

class KartuStokUtils {
  static const Map<String, Map<String, int>> thresholds = {
    'gram': {'habis': 0, 'menipis': 5000, 'max': 24999},
    'kg': {'habis': 0, 'menipis': 5, 'max': 24},
    'pcs': {'habis': 0, 'menipis': 15, 'max': 24},
  };

  static StockStatus computeStatus(int jumlah, String satuan) {
    final unitThresholds = thresholds[satuan];
    if (unitThresholds == null) {
      return StockStatus.habis;
    }

    final habis = unitThresholds['habis']!;
    final menipis = unitThresholds['menipis']!;
    final max = unitThresholds['max']!;

    if (jumlah <= habis) {
      return StockStatus.habis;
    } else if (jumlah <= menipis) {
      return StockStatus.menipis;
    } else if (jumlah <= max) {
      return StockStatus.cukupBanyak;
    } else {
      return StockStatus.masihBanyak;
    }
  }

  static Color getStatusColor(StockStatus status) {
    switch (status) {
      case StockStatus.habis:
        return Colors.red;
      case StockStatus.menipis:
        return Colors.orange;
      case StockStatus.cukupBanyak:
        return Colors.yellow;
      case StockStatus.masihBanyak:
        return Colors.green;
    }
  }

  static String getFormattedStatusName(StockStatus status) {
    switch (status) {
      case StockStatus.habis:
        return 'Habis';
      case StockStatus.menipis:
        return 'Menipis';
      case StockStatus.cukupBanyak:
        return 'Cukup Banyak';
      case StockStatus.masihBanyak:
        return 'Masih Banyak';
    }
  }
}
