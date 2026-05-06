import 'package:flutter/material.dart';
// Pastikan import ini sesuai dengan lokasi file rincian_pesanan_screen.dart kamu
import 'rincian_pesanan_screen.dart'; 

class ProductItem {
  final String name;
  final String variant;
  final int price;
  final String imagePath;
  int quantity;
  bool isSelected;

  ProductItem({
    required this.name,
    required this.variant,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
    this.isSelected = false, // Default awal: tidak tercentang sama sekali
  });
}

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // ==========================================
  // DISINI KITA SESUAIKAN NAMA FILE GAMBAR DAN VARIANNYA, BOS!
  // ==========================================
  final List<ProductItem> _products = [
    ProductItem(
      name: "Buku Tulis", 
      variant: "Varian Campus A5", 
      price: 6000, 
      imagePath: "assets/buku_tulis.png"
    ),
    ProductItem(
      name: "Pensil Staedler", 
      variant: "Varian 2B", 
      price: 4000, 
      imagePath: "assets/pensil.png"
    ),
    ProductItem(
      name: "Map", 
      variant: "Varian Plastik Merah", 
      price: 3500, 
      imagePath: "assets/map.png"
    ),
    ProductItem(
      name: "Penghapus Staedler", 
      variant: "Varian Hitam Kecil", 
      price: 2000, 
      imagePath: "assets/penghapus.png"
    ),
    ProductItem(
      name: "Buku Folio", 
      variant: "Varian Hardcover", 
      price: 9000, 
      imagePath: "assets/buku folio.png"
    ),
    ProductItem(
      name: "Krayon Mini", 
      variant: "Varian 12 Warna", 
      price: 15000, 
      imagePath: "assets/krayon.png"
    ),
    ProductItem(
      name: "Bolpoin", 
      variant: "Varian Tinta Hitam", 
      price: 3000, 
      imagePath: "assets/pulpen.png"
    ),
  ];

  bool _selectAll = false;

  // Menghitung total harga dari produk yang dicentang saja
  int get _totalPrice {
    return _products
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Menghitung jumlah jenis produk yang dicentang
  int get _selectedCount {
    return _products.where((item) => item.isSelected).length;
  }

  // Fungsi centang semua barang
  void _toggleSelectAll(bool? value) {
    if (value != null) {
      setState(() {
        _selectAll = value;
        for (var product in _products) {
          product.isSelected = value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Keranjang",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- LIST PRODUK ---
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final product = _products[index];
                return Row(
                  children: [
                    // Tombol Centang Bulat (Kosong di awal)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          product.isSelected = !product.isSelected;
                          _selectAll = _products.every((item) => item.isSelected);
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: product.isSelected ? const Color(0xFF3B95DE) : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: product.isSelected ? const Color(0xFF3B95DE) : Colors.transparent,
                        ),
                        child: product.isSelected
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ==========================================
                    // DI SINI WIDGET GAMBAR YANG SUDAH MEMBACA ASSETS KAMU
                    // ==========================================
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.cover,
                          // Jika nama file di kodenya beda dengan di folder assets,
                          // dia bakal nampilin gambar abu-abu ini agar tidak nge-crash merah.
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.image, color: Colors.grey, size: 30),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Detail Informasi Produk (Nama Barang, Varian, Harga)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              product.variant,
                              style: TextStyle(color: Colors.grey[600], fontSize: 11),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Rp.${product.price}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    // Tombol hapus (silang) & Qty Changer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _products.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildQtyButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (product.quantity > 1) {
                                  setState(() => product.quantity--);
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "${product.quantity}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            _buildQtyButton(
                              icon: Icons.add,
                              onTap: () {
                                setState(() => product.quantity++);
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                );
              },
            ),
          ),

          // --- BOTTOM BAR ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _selectAll,
                        activeColor: const Color(0xFF3B95DE),
                        onChanged: _toggleSelectAll,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("Semua", style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                
                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Gratis Ongkir",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Rp.$_totalPrice",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),

                ElevatedButton(
                  onPressed: _selectedCount == 0
                      ? null 
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RincianPesananScreen(metodePembayaran: "QRIS"),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B95DE),
                    disabledBackgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Checkout ($_selectedCount)",
                    style: TextStyle(
                      color: _selectedCount == 0 ? Colors.grey[600] : Colors.white,
                      fontWeight: FontWeight.bold,
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

  Widget _buildQtyButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: Colors.grey[600]),
      ),
    );
  }
}