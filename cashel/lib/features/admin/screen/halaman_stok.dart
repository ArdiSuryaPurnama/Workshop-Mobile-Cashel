import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_detail_produk.dart';

class HalamanStock extends StatefulWidget {
  const HalamanStock({super.key});

  @override
  State<HalamanStock> createState() => _HalamanStockState();
}

class _HalamanStockState extends State<HalamanStock> {
  final String baseUrl = 'http://10.0.2.2/api_stock';
  List produk = [];

  @override
  void initState() {
    super.initState();
    getProduk();
  }

  Future<void> getProduk() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_produk.php'));
      if (response.statusCode == 200) {
        setState(() {
          produk = jsonDecode(response.body);
        });
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
        title: const Text(
          'Semua Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: produk.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.72, // Disesuaikan agar kartu lebih tinggi
        ),
        itemBuilder: (context, index) {
          final item = produk[index];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area Gambar
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      // Ganti Icon dengan Image.network jika API menyediakan URL gambar
                      child: Icon(Icons.image, size: 80, color: Colors.grey.shade400),
                    ),
                  ),
                ),
                
                // Pembatas Garis Tipis (Opsional, sesuai gambar)
                Divider(height: 1, color: Colors.grey.shade200),

                // Area Detail & Tombol
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama_produk'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp.${item['harga']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.extrabold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tombol Biru [+]
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditDetailProduk(produk: item),
                            ),
                          );
                          getProduk();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF42A5F5), // Warna biru sesuai gambar
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
