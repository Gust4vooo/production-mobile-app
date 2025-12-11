import 'package:flutter/material.dart';

class ProductionCodeDisplay extends StatelessWidget {
  final String kode;

  const ProductionCodeDisplay({super.key, required this.kode});

  List<Widget> _buildKodeProduksiLines(String kode) {
    List<String> lines = [];
    if (kode.length >= 9) {
      lines.add(kode.substring(0, 2));
      lines.add(kode.substring(2, kode.length - 1));
      lines.add(kode.substring(kode.length - 1));
    } else if (kode.length >= 3) {
      lines.add(kode.substring(0, 2));
      lines.add(kode.substring(2));
    } else {
      lines.add(kode);
    }

    return lines.map((line) => Text(
      line,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: _buildKodeProduksiLines(kode),
      ),
    );
  }
}
