import 'package:flutter/material.dart';
import 'rincian_pesanan_screen.dart'; // Import rincian pesanan agar bisa navigasi

class PesananDiterimaPage extends StatelessWidget {
  // Parameter untuk menampung data realtime dari checkout
  final String metodePembayaran;
  final String namaProduk;
  final int harga;
  final String imagePath;
  final int jumlah;
  final int totalBayar;
  final int ongkir;

  const PesananDiterimaPage({
    super.key, 
    required this.metodePembayaran,
    required this.namaProduk,
    required this.harga,
    required this.imagePath,
    required this.jumlah,
    required this.totalBayar,
    required this.ongkir,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Colors.white], // Gradasi biru muda CASHEL
            stops: [0.0, 0.4],
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3498DB).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF3498DB),
                  size: 100,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Pesanan Berhasil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Pesanan Anda telah kami terima dan akan segera diproses. Terima kasih telah berbelanja!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Meneruskan data produk secara realtime ke RincianPesananScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RincianPesananScreen(
                            metodePembayaran: metodePembayaran,
                            namaProduk: namaProduk,
                            harga: harga,
                            imagePath: imagePath,
                            jumlah: jumlah,
                            totalBayar: totalBayar,
                            ongkir: ongkir,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3498DB),
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Cek Pesanan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    child: const Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}