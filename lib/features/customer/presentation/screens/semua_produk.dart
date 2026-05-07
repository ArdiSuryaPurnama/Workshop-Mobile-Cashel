import 'package:flutter/material.dart';
// Import widget kartu produk untuk menampilkan item di GridView
import '../widgets/produk_card.dart';
// Import file data produk agar data terpusat dan tidak duplikat
import '../data_produk.dart'; 

class SemuaProdukPage extends StatelessWidget {
  const SemuaProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Menyesuaikan skala berdasarkan lebar layar untuk desain yang responsif
        final double scale = constraints.maxWidth / 414;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20 * scale,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Semua Produk",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins', 
                fontWeight: FontWeight.bold,
                fontSize: 20 * scale,
              ),
            ),
            centerTitle: true,
          ),
          body: GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 20 * scale,
              vertical: 10 * scale,
            ),
            // Mengambil jumlah data langsung dari daftarProdukMaster
            itemCount: daftarProdukMaster.length, 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15 * scale,
              crossAxisSpacing: 15 * scale,
              childAspectRatio: 173 / 245,
            ),
            itemBuilder: (context, index) {
              // Mengambil data produk berdasarkan index dari data_produk.dart
              final produk = daftarProdukMaster[index];
              
              return ProdukCard(
                title: produk['title']!,
                price: produk['price']!,
                imagePath: produk['imagePath']!,
                stok: produk['stok']!, 
                description: produk['description']!, 
                scale: scale,
              );
            },
          ),
        );
      },
    );
  }
}