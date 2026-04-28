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
          children: [
            // gambar produk
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pensil Staedler",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // variant
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selectedVariant == index
                          ? AppColors.primary
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(variants[index]),
                  ),
                );
              }),
            ),

            const SizedBox(height: 15),

            // jumlah
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (jumlah > 1) {
                      setState(() => jumlah--);
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text("$jumlah"),
                IconButton(
                  onPressed: () {
                    setState(() => jumlah++);
                  },
                  icon: const Icon(Icons.add),
                ),
                const Spacer(),
                const Text("Rp.5100",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),

            const SizedBox(height: 15),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Detail Produk"),
            ),

            const Text(
              "Pensil berkualitas tinggi cocok untuk menulis dan menggambar.",
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Tambah ke keranjang"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Pesan Sekarang",
                    onPressed: () {},
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