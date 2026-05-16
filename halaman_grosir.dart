import 'package:flutter/material.dart';
import '../widgets/produk_card.dart'; //[cite: 7]

class HalamanGrosir extends StatelessWidget {
  const HalamanGrosir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Grosir',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins', //[cite: 2]
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder( //[cite: 12]
        builder: (context, constraints) {
          final double scale = constraints.maxWidth / 414;
          return GridView.count(
            padding: EdgeInsets.all(20 * scale),
            crossAxisCount: 2,
            mainAxisSpacing: 15 * scale,
            crossAxisSpacing: 15 * scale,
            childAspectRatio: 173 / 248,
            children: [
              ProdukCard(
                title: "Kertas HVS",
                price: "Rp. 4.000",
                imagePath: "assets/images/kertas_hvs.png",
                stok: "500", // Menambahkan parameter stok[cite: 11]
                description: "Kertas HVS A4 berkualitas tinggi untuk kebutuhan cetak dokumen.", // Menambahkan deskripsi[cite: 11]
                scale: scale,
              ),
              ProdukCard(
                title: "Buku tulis",
                price: "Rp. 6.000",
                imagePath: "assets/images/buku_tulis.png",
                stok: "250", //[cite: 11]
                description: "Buku tulis isi 38 lembar dengan kertas putih halus.", //[cite: 11]
                scale: scale,
              ),
              ProdukCard(
                title: "Pensil staedler",
                price: "Rp. 4.000",
                imagePath: "assets/images/pensil.png",
                stok: "100", //[cite: 11]
                description: "Pensil Staedtler 2B asli, ideal untuk ujian dan menulis harian.", //[cite: 11]
                scale: scale,
              ),
              ProdukCard(
                title: "Map big",
                price: "Rp. 3.000",
                imagePath: "assets/images/map.png",
                stok: "400", //[cite: 11]
                description: "Map plastik tebal ukuran folio untuk menjaga kerapihan dokumen.", //[cite: 11]
                scale: scale,
              ),
            ],
          );
        },
      ),
    );
  }
}