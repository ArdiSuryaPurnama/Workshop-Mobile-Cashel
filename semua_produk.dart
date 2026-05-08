import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/produk_card.dart';
import 'tampilan_awal_page.dart'; // Import untuk akses globalKeranjang

class SemuaProdukPage extends StatefulWidget {
  const SemuaProdukPage({super.key});

  @override
  State<SemuaProdukPage> createState() => _SemuaProdukPageState();
}

class _SemuaProdukPageState extends State<SemuaProdukPage> {
  // Simpan Future dalam variabel agar data tidak reload saat UI di-update
  Future<List<dynamic>>? _futureProduk;

  @override
  void initState() {
    super.initState();
    _futureProduk = ambilProdukSatuan();
  }

  // Fungsi tambah ke keranjang realtime
  void _tambahKeKeranjang() {
    globalKeranjang.value++; // Update nilai global
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil ditambahkan ke keranjang", style: TextStyle(fontFamily: 'Poppins')),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF0862FD),
      ),
    );
  }

  Future<List<dynamic>> ambilProdukSatuan() async {
    final String t = DateTime.now().millisecondsSinceEpoch.toString();
    final String url = 'http://localhost/api_cashel/product/get_product.php?kategori=satuan&t=$t';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Kesalahan koneksi Produk Satuan: $e");
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
              "Semua Produk",
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Center(
                  // Pantau angka keranjang secara realtime
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
            future: _futureProduk,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (snapshot.hasError) {
                return Center(child: Text("Terjadi kesalahan: ${snapshot.error}", style: const TextStyle(fontFamily: 'Poppins')));
              }

              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                  // Tetap gunakan PageStorageKey agar posisi scroll terjaga saat tambah barang
                  key: const PageStorageKey<String>('scroll_semua_produk'),
                  padding: EdgeInsets.all(20 * scale),
                  itemCount: snapshot.data!.length, 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15 * scale,
                    crossAxisSpacing: 15 * scale,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final produk = snapshot.data![index];
                    return ProdukCard(
                      title: produk['nama_produk'] ?? "Produk",
                      price: "Rp ${produk['harga'] ?? '0'}",
                      imagePath: "assets/images/${produk['gambar'] ?? 'placeholder.png'}",
                      stok: (produk['stok'] ?? 0).toString(), 
                      description: produk['deskripsi'] ?? "", 
                      scale: scale,
                      onAddTap: _tambahKeKeranjang, // Sinkronisasi realtime
                    );
                  },
                );
              }

              return const Center(
                child: Text("Tidak ada produk satuan tersedia", style: TextStyle(fontFamily: 'Poppins')),
              );
            },
          ),
        );
      },
    );
  }
}