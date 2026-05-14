import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/produk_card.dart';
import 'tampilan_awal_page.dart'; // Import agar bisa akses globalKeranjang

class HalamanGrosir extends StatefulWidget {
  const HalamanGrosir({super.key});

  @override
  State<HalamanGrosir> createState() => _HalamanGrosirState();
}

class _HalamanGrosirState extends State<HalamanGrosir> {
  // Simpan Future dalam variabel agar tidak fetch ulang saat UI update
  Future<List<dynamic>>? _futureGrosir;

  @override
  void initState() {
    super.initState();
    _futureGrosir = ambilDataGrosir();
  }

  // Fungsi tambah ke keranjang yang langsung sinkron ke pusat (realtime)
  void _tambahKeKeranjang() {
    globalKeranjang.value++; // Mengupdate variabel global di tampilan_awal_page
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil ditambahkan ke keranjang", style: TextStyle(fontFamily: 'Poppins')),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF0862FD),
      ),
    );
  }

  Future<List<dynamic>> ambilDataGrosir() async {
    final String t = DateTime.now().millisecondsSinceEpoch.toString();
    final String url = 'http://localhost/api_cashel/product/get_product.php?kategori=grosir&t=$t';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Kesalahan koneksi Grosir: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scale = constraints.maxWidth / 414;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Produk Grosir",
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  // Menampilkan angka keranjang secara realtime
                  child: ValueListenableBuilder<int>(
                    valueListenable: globalKeranjang,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: const Color(0xFF181B19), size: 28 * scale),
                          if (value > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                child: Text(
                                  '$value',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<dynamic>>(
            future: _futureGrosir,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  key: const PageStorageKey<String>('scroll_grosir'), // Jaga posisi scroll agar tidak hilang
                  padding: EdgeInsets.all(20 * scale),
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15 * scale,
                    crossAxisSpacing: 15 * scale,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ProdukCard(
                      title: item['nama_produk'] ?? "Produk",
                      price: "Rp ${item['harga'] ?? '0'}",
                      imagePath: "assets/images/${item['gambar'] ?? 'placeholder.png'}",
                      stok: (item['stok'] ?? 0).toString(),
                      description: item['deskripsi'] ?? "",
                      scale: scale,
                      onAddTap: _tambahKeKeranjang, // Sinkronisasi tombol (+)
                    );
                  },
                );
              }
              return const Center(
                child: Text("Data Grosir Tidak Ditemukan", style: TextStyle(fontFamily: 'Poppins')),
              );
            },
          ),
        );
      },
    );
  }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/produk_card.dart';
import 'tampilan_awal_page.dart'; // Import agar bisa akses globalKeranjang

class HalamanGrosir extends StatefulWidget {
  const HalamanGrosir({super.key});

  @override
  State<HalamanGrosir> createState() => _HalamanGrosirState();
}

class _HalamanGrosirState extends State<HalamanGrosir> {
  // Simpan Future dalam variabel agar tidak fetch ulang saat UI update
  Future<List<dynamic>>? _futureGrosir;

  @override
  void initState() {
    super.initState();
    _futureGrosir = ambilDataGrosir();
  }

  // Fungsi tambah ke keranjang yang langsung sinkron ke pusat (realtime)
  void _tambahKeKeranjang() {
    globalKeranjang.value++; // Mengupdate variabel global di tampilan_awal_page
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil ditambahkan ke keranjang", style: TextStyle(fontFamily: 'Poppins')),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF0862FD),
      ),
    );
  }

  Future<List<dynamic>> ambilDataGrosir() async {
    final String t = DateTime.now().millisecondsSinceEpoch.toString();
    final String url = 'http://localhost/api_cashel/product/get_product.php?kategori=grosir&t=$t';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Kesalahan koneksi Grosir: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scale = constraints.maxWidth / 414;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Produk Grosir",
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  // Menampilkan angka keranjang secara realtime
                  child: ValueListenableBuilder<int>(
                    valueListenable: globalKeranjang,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: const Color(0xFF181B19), size: 28 * scale),
                          if (value > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                child: Text(
                                  '$value',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<dynamic>>(
            future: _futureGrosir,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  key: const PageStorageKey<String>('scroll_grosir'), // Jaga posisi scroll agar tidak hilang
                  padding: EdgeInsets.all(20 * scale),
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15 * scale,
                    crossAxisSpacing: 15 * scale,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ProdukCard(
                      title: item['nama_produk'] ?? "Produk",
                      price: "Rp ${item['harga'] ?? '0'}",
                      imagePath: "assets/images/${item['gambar'] ?? 'placeholder.png'}",
                      stok: (item['stok'] ?? 0).toString(),
                      description: item['deskripsi'] ?? "",
                      scale: scale,
                      onAddTap: _tambahKeKeranjang, // Sinkronisasi tombol (+)
                    );
                  },
                );
              }
              return const Center(
                child: Text("Data Grosir Tidak Ditemukan", style: TextStyle(fontFamily: 'Poppins')),
              );
            },
          ),
        );
      },
    );
  }
}