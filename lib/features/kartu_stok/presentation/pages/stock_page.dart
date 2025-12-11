import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/add_button.dart';
import '../../../../core/widgets/custom_filter_chip.dart';
import '../../../../core/widgets/search_bar.dart';
import '../viewmodels/kartu_stok_view_model.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/database/app.database.dart';
import '../../domain/stok_sort_option.dart';
import '../../domain/stok_sort_option_utils.dart';
import '../widgets/stock_item_card.dart';
import '../widgets/stock_form.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  bool _isBahanBakuExpanded = true;
  bool _isBahanKemasExpanded = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAddStockModal(
    BuildContext context,
    KartuStokViewModel viewModel, {
    KartuStokData? itemToEdit,
  }) {
    if (itemToEdit != null) {
      viewModel.startEditing(itemToEdit);
    } else {
      viewModel.clearFormState();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StockFormModal(viewModel: viewModel);
      },
    ).whenComplete(() {
      viewModel.clearFormState();
    });
  }

@override
Widget build(BuildContext context) {
  final viewModel = context.watch<KartuStokViewModel>();
  final bahanBakuItems = viewModel.bahanBakuList;
  final bahanKemasItems = viewModel.bahanKemasList;

  return Scaffold(
    appBar: const CustomAppBar(title: 'Kartu Stok'),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              _buildSearchAndFilter(viewModel),
              if (viewModel.currentSortOption != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      CustomFilterChip(
                        label:
                            'Urutan: ${StokSortOptionUtils.getSortOptionText(viewModel.currentSortOption)}',
                        onClear: () => viewModel.sortItemsByStatus(null),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : (bahanBakuItems.isEmpty && bahanKemasItems.isEmpty)
                  ? const Center(child: Text('Belum ada data bahan.'))
                  : CustomScrollView(
                      slivers: [
                        if (bahanBakuItems.isNotEmpty) ...[
                          _buildSectionHeader(
                            'Bahan Baku',
                            _isBahanBakuExpanded,
                            () {
                              setState(() {
                                _isBahanBakuExpanded = !_isBahanBakuExpanded;
                              });
                            },
                          ),
                          if (_isBahanBakuExpanded)
                            _buildGrid(context, viewModel, bahanBakuItems),
                        ],
                        if (bahanKemasItems.isNotEmpty) ...[
                          _buildSectionHeader(
                            'Bahan Kemas',
                            _isBahanKemasExpanded,
                            () {
                              setState(() => _isBahanKemasExpanded = !_isBahanKemasExpanded);
                            },
                          ),
                          if (_isBahanKemasExpanded)
                            _buildGrid(context, viewModel, bahanKemasItems),
                        ],
                      ],
                    ),
        ),
      ],
    ),
    floatingActionButton: AddButton(
      onPressed: () => _showAddStockModal(context, viewModel),
    ),
  );
}

  Row _buildSearchAndFilter(KartuStokViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            hintText: 'Cari bahan...',
            onChanged: (value) {
              viewModel.setSearchQuery(value);
            },
          ),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<StockSortOption?>(
          icon: const Icon(Icons.filter_list),
          tooltip: 'Filter by Status',
          initialValue: viewModel.currentSortOption,
          onSelected: (StockSortOption? result) {
            viewModel.sortItemsByStatus(result);
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<StockSortOption?>>[
            const PopupMenuItem<StockSortOption?>(
              value: null,
              child: Text('Semua'),
            ),
            ...StockSortOption.values.map((status) {
              return PopupMenuItem<StockSortOption?>(
                value: status,
                child: Text(StokSortOptionUtils.getSortOptionText(status)),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildSectionHeader(
      String title, bool isExpanded, VoidCallback onTap) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: const Color.fromARGB(255, 7, 117, 70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildGrid(BuildContext context, KartuStokViewModel viewModel,
      List<KartuStokData> items) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = items[index];
            return StockItemCard(
              item: item,
              onTap: () =>
                  _showAddStockModal(context, viewModel, itemToEdit: item),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
