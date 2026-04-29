import 'package:flutter/material.dart';


class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // --- LOGIKA: Simpan jumlah barang di sini ---
  int jumlahBarang = 1; 
  int hargaSatuan = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                // Kita buat satu item contoh yang bisa ditambah/kurang
                _itemKeranjangHidup("Pensil Staedler", "Varian 2B", hargaSatuan),
              ],
            ),
          ),

          // BOTTOM BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                const Text("Semua"),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Total", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(
                      "Rp.${jumlahBarang * hargaSatuan}", // Hitung total otomatis
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                
                // --- TOMBOL CHECKOUT KE HALAMAN SELANJUTNYA ---
                ElevatedButton(
                  onPressed: () {
                    // Pindah ke halaman selanjutnya (misal: HalamanPembayaran)
                    print("Lanjut ke Checkout");
                    /* Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const HalamanSelanjutnya())
                    );
                    */
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B95DE),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Checkout ($jumlahBarang)", style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemKeranjangHidup(String title, String variant, int price) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF3B95DE), size: 28),
            const SizedBox(width: 10),
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp.$price"),
                      Row(
                        children: [
                          // TOMBOL KURANG (-)
                          _tombolAksi(Icons.remove, () {
                            if (jumlahBarang > 1) {
                              setState(() {
                                jumlahBarang--;
                              });
                            }
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text("$jumlahBarang", style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          // TOMBOL TAMBAH (+)
                          _tombolAksi(Icons.add, () {
                            setState(() {
                              jumlahBarang++;
                            });
                          }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 30),
      ],
    );
  }

  Widget _tombolAksi(IconData icon, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF3B95DE)),
      ),
    );
  }
}