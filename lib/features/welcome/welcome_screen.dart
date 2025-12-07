import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color primaryColor = Color(0xFF077546);
const Color whiteColor = Colors.white;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Tambahkan Ilustrasi di sini
              // Image.asset(
              //   'assets/images/lumbung_illustration.png', 
              //   height: 250,
              // ),
              const SizedBox(height: 40),
              const Text(
                'LUMBUNG',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kelola Produksi dan Stok dengan Mudah',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: primaryColor,
                  backgroundColor: whiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
