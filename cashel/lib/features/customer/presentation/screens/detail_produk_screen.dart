import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';

class DetailProdukScreen extends StatefulWidget {
  const DetailProdukScreen({super.key});

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  int jumlah = 1;
  int selectedVariant = 0; // Default ke index 0 (2B)

  final List<String> variants = ["2B", "4B", "6B", "HB"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // extendBodyBehindAppBar agar gambar bisa mentok ke atas melewati appbar
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.shopping_cart_outlined, color: Colors.black),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          // Expanded digunakan agar SingleChildScrollView mengambil sisa ruang di atas tombol
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Gambar Produk dengan Background Melengkung (Sesuai Gambar 2)
                  Container(
                    height: 380,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/pensil.png', // Sesuaikan path asset
                        height: 280,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 2. Nama & Harga Produk (Sesuai Layout Gambar 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Pensil Staedler",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Rp.5100",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Text("Varian", style: TextStyle(color: Colors.grey[600])),
                        const SizedBox(height: 10),

                        // 3. List Variant
                        Row(
                          children: List.generate(variants.length, (index) {
                            bool isSelected = selectedVariant == index;
                            return GestureDetector(
                              onTap: () => setState(() => selectedVariant = index),
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue[50] : Colors.grey[200],
                                  border: Border.all(
                                    color: isSelected ? AppColors.primary : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  variants[index],
                                  style: TextStyle(
                                    color: isSelected ? AppColors.primary : Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 25),
                        Text("Jumlah", style: TextStyle(color: Colors.grey[600])),
                        
                        // 4. Counter Jumlah
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => setState(() {
                                if (jumlah > 1) jumlah--;
                              }),
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.blue),
                            ),
                            Text("$jumlah", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => setState(() => jumlah++),
                              icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                            ),
                          ],
                        ),

                        const Divider(height: 40),

                        // 5. Detail Produk
                        const Text("Detail Produk", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        const Text(
                          "Staedler Mars Lumograph 4B\nPensil 4B Lebih Gelap, Cocok Untuk Menulis Tebal Dan Sketsa Ringan. Warna Lebih Hitam\nKekerasan : Lebih Lunak Dari 2B\nDiameter Isi : 2,5mm",
                          style: TextStyle(color: Colors.black87, height: 1.5),
                        ),

                        const SizedBox(height: 25),
                        
                        // 6. Info Stok
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Stok", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text("255", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 7. Tombol Bottom (Sticky di bawah layar)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Tambah ke keranjang", style: TextStyle(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomButton(
                    text: "Pesan Sekarang",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}