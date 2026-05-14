import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_produk_screen.dart';
import 'checkout.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  static List<Map<String, dynamic>> listKeranjangGlobal = [];

  static void tambahKeKeranjangStatic(Map<String, dynamic> produkBaru) {
    int index = listKeranjangGlobal.indexWhere((item) => item['title'] == produkBaru['title']);
    if (index != -1) {
      listKeranjangGlobal[index]['jumlah'] += (produkBaru['jumlah'] ?? 1);
    } else {
      produkBaru['selected'] = true;
      listKeranjangGlobal.add(produkBaru);
    }
  }

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool selectAll = true;

  @override
  void initState() {
    super.initState();
    _rapikanKeranjang(); // Langkah 1: Bersihkan tumpukan saat masuk
    _muatDataKeranjang();
  }

  // FUNGSI PEMBERSIH: Menyatukan barang duplikat menjadi satu baris
  void _rapikanKeranjang() {
    Map<String, Map<String, dynamic>> tempMap = {};
    for (var item in KeranjangPage.listKeranjangGlobal) {
      String nama = item['title'];
      if (tempMap.containsKey(nama)) {
        tempMap[nama]!['jumlah'] += item['jumlah'];
      } else {
        tempMap[nama] = Map<String, dynamic>.from(item);
      }
    }
    setState(() {
      KeranjangPage.listKeranjangGlobal = tempMap.values.toList();
    });
  }

  Future<void> _muatDataKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataTeks = prefs.getString('keranjang_data');

    setState(() {
      if (dataTeks != null && dataTeks.isNotEmpty) {
        List<dynamic> mentah = jsonDecode(dataTeks);
        List<Map<String, dynamic>> dataHP =
            mentah.map((e) => Map<String, dynamic>.from(e)).toList();

        if (KeranjangPage.listKeranjangGlobal.isEmpty) {
          KeranjangPage.listKeranjangGlobal = dataHP;
        } else {
          _simpanDataKeHP();
        }
      }
      _updateSelectAllStatus();
    });
  }

  void _updateSelectAllStatus() {
    if (KeranjangPage.listKeranjangGlobal.isNotEmpty) {
      selectAll = KeranjangPage.listKeranjangGlobal.every((e) => e['selected']);
    } else {
      selectAll = false;
    }
  }

  Future<void> _simpanDataKeHP() async {
    final prefs = await SharedPreferences.getInstance();
    String dataTeks = jsonEncode(KeranjangPage.listKeranjangGlobal);
    await prefs.setString('keranjang_data', dataTeks);
  }

  int get totalHarga {
    int total = 0;
    for (var item in KeranjangPage.listKeranjangGlobal) {
      if (item['selected']) {
        String cleanPrice = item['price'].toString().replaceAll(RegExp(r'[^0-9]'), '');
        int price = int.tryParse(cleanPrice) ?? 0;
        total += price * (item['jumlah'] as int);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    bool adaYangDipilih = KeranjangPage.listKeranjangGlobal.any((item) => item['selected']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Keranjang",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          Expanded(
            child: KeranjangPage.listKeranjangGlobal.isEmpty
                ? const Center(
                    child: Text("Keranjang Kosong", style: TextStyle(fontFamily: 'Poppins')))
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: KeranjangPage.listKeranjangGlobal.length,
                    itemBuilder: (context, index) => _buildCartItem(index),
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  activeColor: const Color(0xFF3498DB),
                  onChanged: (val) {
                    setState(() {
                      selectAll = val!;
                      for (var item in KeranjangPage.listKeranjangGlobal) {
                        item['selected'] = val;
                      }
                      _simpanDataKeHP();
                    });
                  },
                ),
                const Text("Semua", style: TextStyle(fontFamily: 'Poppins', fontSize: 13)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Total Harga",
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text(
                        "Rp $totalHarga",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color(0xFF3498DB)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: !adaYangDipilih
                      ? null 
                      : () {
                          // LOGIKA MULTI-CHECKOUT CERDAS
                          var listTerpilih = KeranjangPage.listKeranjangGlobal
                              .where((item) => item['selected'] == true)
                              .toList();

                          // Gabungkan nama semua barang: "Pensil (2x), Buku (1x)"
                          String namaGabungan = listTerpilih
                              .map((e) => "${e['title']} (${e['jumlah']}x)")
                              .join(", ");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                namaProduk: namaGabungan,
                                harga: totalHarga, // Menggunakan getter totalHarga yang sudah ada
                                imagePath: listTerpilih.first['imagePath'],
                                jumlah: 1, // Detail jumlah sudah ada di teks namaGabungan
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: adaYangDipilih ? const Color(0xFF3498DB) : Colors.grey.shade300,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index) {
    var item = KeranjangPage.listKeranjangGlobal[index];

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  item['selected'] = !item['selected'];
                  _updateSelectAllStatus();
                  _simpanDataKeHP();
                });
              },
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: item['selected'] ? const Color(0xFF3498DB) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: item['selected'] ? const Color(0xFF3498DB) : const Color(0xFFE2E2E2)),
                ),
                child: item['selected']
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F2), borderRadius: BorderRadius.circular(10)),
              child: Image.asset(item['imagePath'],
                  fit: BoxFit.contain, errorBuilder: (c, e, s) => const Icon(Icons.image)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(item['title'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              overflow: TextOverflow.ellipsis)),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            DetailProdukScreen.totalItemDiKeranjangGlobal -= (item['jumlah'] as int);
                            KeranjangPage.listKeranjangGlobal.removeAt(index);
                            _updateSelectAllStatus();
                            _simpanDataKeHP();
                          });
                        },
                        child: const Icon(Icons.close, color: Colors.grey, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['price'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Color(0xFF3498DB))),
                      Row(
                        children: [
                          _counterIcon(Icons.remove, () {
                            if (item['jumlah'] > 1) {
                              setState(() {
                                item['jumlah']--;
                                DetailProdukScreen.totalItemDiKeranjangGlobal--;
                                _simpanDataKeHP();
                              });
                            }
                          }),
                          Container(
                            width: 30,
                            alignment: Alignment.center,
                            child: Text("${item['jumlah']}",
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          _counterIcon(Icons.add, () {
                            setState(() {
                              item['jumlah']++;
                              DetailProdukScreen.totalItemDiKeranjangGlobal++;
                              _simpanDataKeHP();
                            });
                          }, isBlue: true),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 30, thickness: 1, color: Color(0xFFF1F1F1)),
      ],
    );
  }

  Widget _counterIcon(IconData icon, VoidCallback onTap, {bool isBlue = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(5)),
        child: Icon(icon, color: isBlue ? const Color(0xFF3498DB) : Colors.grey, size: 18),
      ),
    );
  }
}