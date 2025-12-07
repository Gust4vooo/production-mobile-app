import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/add_button.dart';
import '../../../../core/widgets/search_bar.dart';
import '../viewmodels/kartu_stok_view_model.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/database/app.database.dart';
import '../widgets/stock_item_card.dart';
import '../../../../core/widgets/status_filter_button.dart';
import '../widgets/stock_form.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
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

  return Scaffold(
    appBar: const CustomAppBar(title: 'Kartu Stok'),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
              StatusFilterButton(
                offset: const Offset(-7, 8),
                currentSortOption: viewModel.currentSortOption,
                onSortChanged: (option) {
                  viewModel.sortItemsByStatus(option);
                },
              ),
            ],
          ),
        ),
          // Grid View
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75, 
                    ),
                    itemCount: viewModel.filteredKartuStokList.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.filteredKartuStokList[index];
                      return StockItemCard(
                        item: item,
                        onTap: () => _showAddStockModal(context, viewModel, itemToEdit: item),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: AddButton(
        onPressed: () => _showAddStockModal(context, viewModel),
      ),
    );
  }
}
