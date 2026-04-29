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
  int selectedVariant = 1;

  final List<String> variants = ["2B", "4B", "6B", "HB"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Icon(Icons.shopping_cart, color: Colors.black),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // INI KUNCINYA: Membuat semua konten rata kiri
          children: [
            // 1. Gambar Produk (Bisa diganti Image.network atau Image.asset nanti)
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(child: Icon(Icons.image, size: 100, color: Colors.grey)),
            ),

            const SizedBox(height: 20),

            // 2. Judul Produk
            const Text(
              "Pensil Staedler",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            // 3. Teks Varian (Sesuai Figma)
            Text(
              "Varian",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),

            const SizedBox(height: 10),

            // 4. List Variant
            Row(
              children: List.generate(variants.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVariant = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedVariant == index
                          ? AppColors.primary.withOpacity(0.2) // Warna background saat dipilih
                          : Colors.grey[200],
                      border: Border.all(
                        color: selectedVariant == index ? AppColors.primary : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      variants[index],
                      style: TextStyle(
                        color: selectedVariant == index ? AppColors.primary : Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // 5. Bagian Jumlah & Harga
            const Text("Jumlah", style: TextStyle(color: Colors.grey, fontSize: 14)),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => setState(() => jumlah > 1 ? jumlah-- : null),
                        icon: const Icon(Icons.remove, size: 20),
                      ),
                      Text("$jumlah", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => setState(() => jumlah++),
                        icon: const Icon(Icons.add, size: 20, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text(
                  "Rp.5100",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(), // Garis pembatas halus

            // 6. Detail Produk (Sekarang Rata Kiri)
            const Text(
              "Detail Produk",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Pensil berkualitas tinggi cocok untuk menulis dan menggambar. Memiliki mata pensil yang kuat dan tidak mudah patah.",
              style: TextStyle(color: Colors.black87, height: 1.5),
              textAlign: TextAlign.left, // Memastikan rata kiri
            ),

            const SizedBox(height: 20),

            // 7. Info Stok (Sesuai Figma)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Stok", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text("180", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const Spacer(), // Mendorong tombol ke paling bawah

            // 8. Tombol Aksi
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: const Text("Tambah ke keranjang", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: CustomButton(
                      text: "Pesan Sekarang",
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
        );
  }
}