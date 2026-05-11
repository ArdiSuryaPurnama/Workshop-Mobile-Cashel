import 'package:flutter/material.dart';
import 'keranjang_page.dart';
import 'checkout.dart'; 
<<<<<<< HEAD
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6

class DetailProdukScreen extends StatefulWidget {
  final Map<String, String> produk;
  const DetailProdukScreen({super.key, required this.produk});

  static int totalItemDiKeranjangGlobal = 0;

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  int jumlah = 1;
  double cartScale = 1.0; 

  void _tambahKeKeranjang() {
    setState(() {
      DetailProdukScreen.totalItemDiKeranjangGlobal += jumlah;

      KeranjangPage.listKeranjangGlobal.add({
        'title': widget.produk['title'] ?? 'Nama Produk',
        'price': widget.produk['price'] ?? 'Rp. 0',
        'imagePath': widget.produk['imagePath'] ?? 'assets/images/pensil.png',
        'jumlah': jumlah,
        'selected': true, 
      });

      cartScale = 1.4; 
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => cartScale = 1.0);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil menambahkan $jumlah item ke keranjang"),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF3498DB),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 380,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F3F2),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            widget.produk['imagePath'] ?? 'assets/images/pensil.png',
                            height: 280,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  AnimatedScale(
                                    scale: cartScale,
                                    duration: const Duration(milliseconds: 200),
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 28),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const KeranjangPage()),
                                        );
                                      },
                                    ),
                                  ),
                                  if (DetailProdukScreen.totalItemDiKeranjangGlobal > 0)
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                        child: Text(
                                          "${DetailProdukScreen.totalItemDiKeranjangGlobal}",
                                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.produk['title'] ?? 'Nama Produk',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF181725),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jumlah",
                                  style: TextStyle(color: Color(0xFF7C7C7C), fontFamily: 'Poppins', fontSize: 16),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _buildCounterIcon(Icons.remove, () {
                                      if (jumlah > 1) setState(() => jumlah--);
                                    }),
                                    const SizedBox(width: 15),
                                    Container(
                                      width: 45,
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xFFE2E2E2)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "$jumlah",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    _buildCounterIcon(Icons.add, () => setState(() => jumlah++), isBlue: true),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              widget.produk['price'] ?? 'Rp. 0',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: Color(0xFF181725),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(color: Color(0xFFE2E2E2), thickness: 1),
                        ),
                        const Text(
                          "Detail Produk",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.produk['description'] ?? 'Stae Dler Mars Lumograph 2B\nPensil Standar 2B Untuk Ujian, Tulisan Halus Dan Tidak Terlalu Gelap.',
                          style: const TextStyle(color: Colors.black, height: 1.5, fontFamily: 'Poppins', fontSize: 14),
                        ),
                        const SizedBox(height: 20),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF3498DB), width: 1.2),
                    ),
                    child: InkWell(
                      onTap: _tambahKeKeranjang,
                      borderRadius: BorderRadius.circular(10),
                      child: const Center(
                        child: Text(
                          "Tambah ke keranjang",
                          style: TextStyle(color: Color(0xFF3498DB), fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3498DB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Mengambil angka saja dari string harga (misal: "Rp. 4.000" -> 4000)
                        String rawPrice = widget.produk['price'] ?? '0';
                        int cleanPrice = int.tryParse(rawPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              namaProduk: widget.produk['title'] ?? 'Nama Produk',
                              harga: cleanPrice,
                              imagePath: widget.produk['imagePath'] ?? 'assets/images/pensil.png',
                              jumlah: jumlah,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: const Center(
                        child: Text(
                          "Pesan Sekarang",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterIcon(IconData icon, VoidCallback onTap, {bool isBlue = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon, 
        color: isBlue ? const Color(0xFF3498DB) : const Color(0xFFB1B1B1), 
        size: 28
      ),
    );
  }
}