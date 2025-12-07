import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Pages
import '../features/dashboard/presentation/pages/dashboard.dart';
import '../features/produksi/presentation/pages/production_page.dart';
import '../features/produksi/presentation/pages/production_form_page.dart';
import '../features/produksi/presentation/pages/production_edit_form_page.dart';
import '../features/produksi/presentation/pages/product_detail_page.dart';
import '../features/kartu_stok/presentation/pages/stock_page.dart';
import '../features/welcome/welcome_screen.dart';
import '../navbar.dart';

// Navigator Keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router Configuration
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [

    /// Welcome Screen
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const WelcomeScreen(),
      ),
    ),

    /// ShellRoute untuk menampung BottomNavigationBar
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: child,
          bottomNavigationBar: const CustomBottomNavBar(),
        );
      },
      routes: [
        /// Dashboard Page
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const DashboardScreen(),
          ),
        ),

        /// Halaman Produksi
        GoRoute(
          path: '/production',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProductionScreen(),
          ),
        ),

        /// Halaman Kartu Stok
        GoRoute(
          path: '/stock',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const StockScreen(),
          ),
        ),
      ],
    ),

    /// Form Tambah Produksi
    GoRoute(
      path: '/production/add',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProductionFormPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    ),

    /// Form Edit Produk
    GoRoute(
      path: '/production/edit/:id',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: ProductionEditFormPage(produksiId: state.pathParameters['id']!),
      ),
    ),

    /// Detail Produk
    GoRoute(
      path: '/production/detail/:id',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: ProductDetailPage(produksiId: state.pathParameters['id']!),
      ),
    ),
  ],
);
