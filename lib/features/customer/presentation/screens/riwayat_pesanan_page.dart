import 'package:flutter/material.dart';
import 'rincian_pesanan_screen.dart'; // Untuk navigasi ke detail pesanan[cite: 13, 16]

class RiwayatPesananPage extends StatelessWidget {
  const RiwayatPesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Riwayat Pesanan",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Halaman Riwayat Pesanan",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}