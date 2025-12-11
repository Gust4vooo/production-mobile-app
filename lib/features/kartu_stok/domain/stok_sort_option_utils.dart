// import 'package:flutter/material.dart';
import 'stok_sort_option.dart';

class StokSortOptionUtils {
  static String getSortOptionText(StockSortOption? option) {
    switch (option) {
      case StockSortOption.byStatusEmpty:
        return 'Urutkan dari Stok Banyak';
      case StockSortOption.byStatusPlenty:
        return 'Urutkan dari Stok Sedikit/Habis';
      case null:
        return 'Semua';
    }
  }
}
