import 'package:flutter/material.dart';
import '../screens/detail_produk_screen.dart';

class ProdukCard extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;
  final String stok;
  final String description;
  final double scale;
  // 1. Tambahkan parameter onAddTap di sini
  final VoidCallback? onAddTap; 

  const ProdukCard({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.stok,
    required this.description,
    required this.scale,
    // 2. Masukkan ke dalam constructor
    this.onAddTap, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukScreen(
              produk: {
                'title': title,
                'price': price,
                'imagePath': imagePath,
                'stok': stok,
                'description': description,
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15 * scale),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140 * scale,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromARGB(248, 192, 191, 191).withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15 * scale)),
                child: Padding(
                  padding: EdgeInsets.all(12 * scale),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14 * scale, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(fontSize: 14 * scale, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: const Color(0xFF181725)),
                      ),
                      // 3. Bungkus tombol (+) dengan InkWell agar bisa diklik secara terpisah
                      InkWell(
                        onTap: onAddTap,
                        borderRadius: BorderRadius.circular(10 * scale),
                        child: Container(
                          padding: EdgeInsets.all(6 * scale),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3498DB), 
                            borderRadius: BorderRadius.circular(10 * scale)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 18 * scale),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}