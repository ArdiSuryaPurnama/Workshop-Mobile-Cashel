import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'dart:convert'; // Untuk encode/decode data
import 'package:shared_preferences/shared_preferences.dart'; // Untuk simpan di HP
import 'detail_produk_screen.dart';
import 'checkout.dart'; 
=======
import 'detail_produk_screen.dart'; // Import untuk akses badge global
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

<<<<<<< HEAD
=======
  // List global untuk menampung berbagai produk[cite: 6]
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
  static List<Map<String, dynamic>> listKeranjangGlobal = [];

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool selectAll = true;

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    // 1. MUAT DATA DARI HP SAAT HALAMAN DIBUKA
    _muatDataKeranjang();
  }

  // --- FUNGSI LOGIKA PERMANEN ---

  Future<void> _muatDataKeranjang() async {
    final prefs = await SharedPreferences.getInstance();
    String? dataTeks = prefs.getString('keranjang_data');
    if (dataTeks != null) {
      setState(() {
        List<dynamic> mentah = jsonDecode(dataTeks);
        KeranjangPage.listKeranjangGlobal = mentah.map((e) => Map<String, dynamic>.from(e)).toList();
        // Cek apakah semua item terpilih
        selectAll = KeranjangPage.listKeranjangGlobal.every((e) => e['selected']);
      });
    }
  }

  Future<void> _simpanDataKeHP() async {
    final prefs = await SharedPreferences.getInstance();
    String dataTeks = jsonEncode(KeranjangPage.listKeranjangGlobal);
    await prefs.setString('keranjang_data', dataTeks);
  }

  // --- LOGIKA HITUNG HARGA ---

=======
  // Hitung total harga hanya untuk produk yang tercentang
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
  int get totalHarga {
    int total = 0;
    for (var item in KeranjangPage.listKeranjangGlobal) {
      if (item['selected']) {
<<<<<<< HEAD
        // Membersihkan string harga agar jadi angka murni
        String cleanPrice = item['price'].toString().replaceAll(RegExp(r'[^0-9]'), '');
        int price = int.tryParse(cleanPrice) ?? 0;
=======
        // Membersihkan string "Rp. " dan "." untuk dikonversi ke int
        int price = int.parse(item['price'].replaceAll('Rp. ', '').replaceAll('.', ''));
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
        total += price * (item['jumlah'] as int);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
<<<<<<< HEAD
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
=======
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, size: 22), onPressed: () => Navigator.pop(context)),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
        title: const Text("Keranjang", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true, elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          Expanded(
            child: KeranjangPage.listKeranjangGlobal.isEmpty 
              ? const Center(child: Text("Keranjang Kosong", style: TextStyle(fontFamily: 'Poppins')))
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: KeranjangPage.listKeranjangGlobal.length,
<<<<<<< HEAD
                  itemBuilder: (context, index) => _buildCartItem(index),
                ),
          ),
          
          // BOTTOM BAR CHECKOUT
=======
                  itemBuilder: (context, index) {
                    return _buildCartItem(index);
                  },
                ),
          ),
          
          // BOTTOM BAR CHECKOUT[cite: 5]
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
          Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 35),
            decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              children: [
                SizedBox(
                  width: 24, height: 24,
                  child: Checkbox(
                    value: selectAll, 
                    onChanged: (val) {
                      setState(() {
                        selectAll = val!;
                        for (var item in KeranjangPage.listKeranjangGlobal) {
                          item['selected'] = val;
                        }
<<<<<<< HEAD
                        _simpanDataKeHP(); // SIMPAN PERUBAHAN
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Semua", style: TextStyle(fontFamily: 'Poppins')),
                const Spacer(),
                Text("Rp.$totalHarga", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Poppins')),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3498DB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
<<<<<<< HEAD
                  child: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
=======
                  child: Text("Checkout", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
=======
            // CHECKBOX BULAT INTERAKTIF[cite: 2]
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
            GestureDetector(
              onTap: () {
                setState(() {
                  item['selected'] = !item['selected'];
                  selectAll = KeranjangPage.listKeranjangGlobal.every((e) => e['selected']);
<<<<<<< HEAD
                  _simpanDataKeHP(); // SIMPAN PERUBAHAN
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: item['selected'] ? const Color(0xFF3498DB) : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: item['selected'] ? const Color(0xFF3498DB) : const Color(0xFFE2E2E2)),
                  ),
                  child: item['selected'] ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                ),
              ),
            ),
            const SizedBox(width: 12),
<<<<<<< HEAD
=======
            // GAMBAR PRODUK DINAMIS[cite: 2]
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
            Container(
              width: 90, height: 90,
              decoration: BoxDecoration(color: const Color(0xFFF2F3F2), borderRadius: BorderRadius.circular(12)),
              child: Image.asset(item['imagePath'], fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins')),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFFB1B1B1), size: 20),
                        onPressed: () {
                          setState(() {
<<<<<<< HEAD
                            DetailProdukScreen.totalItemDiKeranjangGlobal -= (item['jumlah'] as int);
                            KeranjangPage.listKeranjangGlobal.removeAt(index);
                            _simpanDataKeHP(); // SIMPAN PERUBAHAN
=======
                            // Update badge global saat item dihapus[cite: 6]
                            DetailProdukScreen.totalItemDiKeranjangGlobal -= (item['jumlah'] as int);
                            KeranjangPage.listKeranjangGlobal.removeAt(index);
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['price'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Poppins')),
<<<<<<< HEAD
=======
                      // COUNTER JUMLAH[cite: 5]
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                      Row(
                        children: [
                          _counterIcon(Icons.remove, () {
                            if (item['jumlah'] > 1) {
                              setState(() {
                                item['jumlah']--;
                                DetailProdukScreen.totalItemDiKeranjangGlobal--;
<<<<<<< HEAD
                                _simpanDataKeHP(); // SIMPAN PERUBAHAN
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
                              });
                            }
                          }),
                          Container(
                            width: 35, alignment: Alignment.center, margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E2E2)), borderRadius: BorderRadius.circular(8)),
                            child: Text("${item['jumlah']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          _counterIcon(Icons.add, () {
                            setState(() {
                              item['jumlah']++;
                              DetailProdukScreen.totalItemDiKeranjangGlobal++;
<<<<<<< HEAD
                              _simpanDataKeHP(); // SIMPAN PERUBAHAN
=======
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
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
    return GestureDetector(onTap: onTap, child: Icon(icon, color: isBlue ? const Color(0xFF3498DB) : const Color(0xFFB1B1B1), size: 22));
  }
}