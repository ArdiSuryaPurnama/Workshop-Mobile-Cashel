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

  // --- FUNGSI POP-UP KONFIRMASI (MODAL BOTTOM SHEET) ---
  void _showConfirmationSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        // Menggunakan StatefulBuilder agar angka jumlah & varian di pop-up bisa berubah saat diklik
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Pop-up: Gambar kecil & Info Harga
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/pensil.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Rp.5100", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Stok: 255", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  const Divider(height: 30),

                  // Pilih Varian di dalam Pop-up
                  const Text("Varian", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: List.generate(variants.length, (index) {
                      bool isSelected = selectedVariant == index;
                      return ChoiceChip(
                        label: Text(variants[index]),
                        selected: isSelected,
                        onSelected: (val) {
                          // Gunakan setModalState untuk update UI di dalam Pop-up
                          setModalState(() => selectedVariant = index);
                          // Gunakan setState untuk sinkronisasi dengan halaman detail di belakangnya
                          setState(() => selectedVariant = index);
                        },
                        selectedColor: Colors.blue[50],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Atur Jumlah di dalam Pop-up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Jumlah", style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (jumlah > 1) {
                                setModalState(() => jumlah--);
                                setState(() => jumlah--);
                              }
                            },
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.blue),
                          ),
                          Text("$jumlah", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            onPressed: () {
                              setModalState(() => jumlah++);
                              setState(() => jumlah++);
                            },
                            icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Tombol Konfirmasi Akhir
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Konfirmasi",
                      onPressed: () {
                        // Nanti di sini arahkan ke halaman Checkout
                        print("Terkonfirmasi: ${variants[selectedVariant]} sejumlah $jumlah");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Gambar Produk
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
                        'assets/pensil.png',
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
                        // 2. Nama & Harga
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

                        // 3. List Variant (Halaman Utama)
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
                        
                        // 4. Counter Jumlah (Halaman Utama)
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

          // 7. Tombol Bottom (Sticky)
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
                    onPressed: () {
                      // DI SINI LETAK PEMANGGILANNYA
                      _showConfirmationSheet();
                    },
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