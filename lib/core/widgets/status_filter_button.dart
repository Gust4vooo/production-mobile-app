import 'package:flutter/material.dart';
import 'package:seger/features/kartu_stok/domain/stok_sort_option.dart';

class StatusFilterButton extends StatelessWidget {
  final Function(StockSortOption option) onSortChanged;
  final Offset offset;
  final StockSortOption? currentSortOption;

  const StatusFilterButton({
    super.key,
    required this.onSortChanged,
    this.offset = const Offset(0, 0),
    this.currentSortOption,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: PopupMenuButton<StockSortOption>(
        onSelected: onSortChanged,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<StockSortOption>>[
          const PopupMenuItem<StockSortOption>(
            value: StockSortOption.byStatusEmpty,
            child: Text('Urutkan dari status Masih Banyak'),
          ),
          const PopupMenuItem<StockSortOption>(
            value: StockSortOption.byStatusPlenty,
            child: Text('Urutkan dari status Habis'),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: const Color.fromARGB(255, 7, 117, 70)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sort, color: Color.fromARGB(255, 7, 117, 70)),
              if (currentSortOption != null) ...[
                const SizedBox(width: 4),
                Icon(
                  currentSortOption == StockSortOption.byStatusPlenty
                      ? Icons.arrow_upward // Masih Banyak -> panah bawah
                      : Icons.arrow_downward,   // Habis -> panah atas
                  size: 18,
                  color: const Color.fromARGB(255, 7, 117, 70),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}