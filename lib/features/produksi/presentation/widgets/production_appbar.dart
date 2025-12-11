import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomProductionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;

  const CustomProductionAppBar({
    super.key,
    this.title = 'Form Produksi',
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => context.pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
