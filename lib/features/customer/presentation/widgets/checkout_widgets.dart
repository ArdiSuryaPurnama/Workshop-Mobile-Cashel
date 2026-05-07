import 'package:flutter/material.dart';

// Jika butuh merujuk ke produk card di folder yang sama
import 'produk_card.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});
  @override
  Widget build(BuildContext context) => const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1));
}

class RincianRow extends StatelessWidget {
  final String label, value;
  final bool isBold;
  const RincianRow({super.key, required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: isBold ? Colors.black : const Color(0xFF7C7C7C), fontFamily: 'Poppins')),
          Text(value, style: TextStyle(fontSize: 12, fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontFamily: 'Poppins')),
        ],
      ),
    );
  }
}