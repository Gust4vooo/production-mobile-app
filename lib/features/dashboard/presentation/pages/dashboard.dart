import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seger/core/widgets/custom_app_bar.dart';
import 'package:seger/features/dashboard/presentation/widgets/dashboard_latest_productions.dart';
import 'package:seger/features/dashboard/presentation/widgets/dashboard_production_summary.dart';
import 'package:seger/features/dashboard/presentation/widgets/dashboard_section_title.dart';
import 'package:seger/features/dashboard/presentation/widgets/dashboard_stock_summary.dart';
import 'package:seger/features/kartu_stok/presentation/viewmodels/kartu_stok_view_model.dart';
import 'package:seger/features/produksi/presentation/viewmodels/produksi_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  bool _isHovered = false;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KartuStokViewModel>().fetchKartuStok();
      context.read<ProduksiViewModel>().fetchProduksi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final produksiViewModel = context.watch<ProduksiViewModel>();
    final kartuStokViewModel = context.watch<KartuStokViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard'),
      body: produksiViewModel.isLoading || kartuStokViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await produksiViewModel.fetchProduksi();
                await kartuStokViewModel.fetchKartuStok();
              },
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Bagian Header (Selamat Datang + Ringkasan Stok)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade300,
                          Colors.green.shade500, 
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Selamat Datang!',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, 
                                    ),
                                  ),
                                  const Text(
                                    'Berikut ringkasan aktivitas produksi Anda.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70, // Teks Putih Transparan
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/images/nailong_hijau.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Bagian Ringkasan Stok 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ringkasan Stok',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            MouseRegion( 
                              onEnter: (_) => setState(() => _isHovered = true), 
                              onExit: (_) => setState(() => _isHovered = false),  
                              child: InkWell(
                                onTap: () => context.go('/stock'),
                                borderRadius: BorderRadius.circular(8),
                                splashColor: Colors.white.withOpacity(0.2),
                                highlightColor: Colors.white.withOpacity(0.1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    'Lihat Semua',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _isHovered ? Colors.white : Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DashboardStockSummary(viewModel: kartuStokViewModel),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Aktivitas Produksi Terbaru
                  DashboardSectionTitle(title: 'Produksi Terbaru', route: '/production'),
                  const SizedBox(height: 10),
                  DashboardLatestProductions(viewModel: produksiViewModel),
                  const SizedBox(height: 30),
                  // Ringkasan Status Produksi
                  DashboardSectionTitle(title: 'Ringkasan Status Produksi', route: '/production'),
                  const SizedBox(height: 10),
                  DashboardProductionSummary(viewModel: produksiViewModel),
                ],
              ),
            ),
    );
  }


}