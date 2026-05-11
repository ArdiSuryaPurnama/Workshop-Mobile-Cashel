import 'package:flutter/material.dart';

class HasilAkhirPembatalan extends StatelessWidget {
  const HasilAkhirPembatalan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Rincian Pesanan", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Banner Status Dibatalkan (Sesuai Gambar 4)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF3B95DE), // Biru banner
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pesanan Dibatalkan pada 16 April", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 4),
                  Text("Dibatalkan oleh Pembeli", 
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),

            // 2. Info Pengiriman
            _buildSection(Icons.local_shipping_outlined, "Info Pengiriman", "Hemat Kargo - SPX Hemat"),
            const Divider(height: 1),
            _buildSection(Icons.location_on_outlined, "Alamat Pengiriman", 
              "Jefri Nichol (+62) 852 1234 8765\nJl A Yani, Kecamatan Nganjuk, Kabupaten Nganjuk, JAWA TIMUR"),

            const SizedBox(height: 12),

            // 3. Card Produk
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        color: Colors.red,
                        child: const Text("Star+", style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      const SizedBox(width: 8),
                      const Text("CASHEL", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.image)),
                      const SizedBox(width: 12),
                      const Expanded(child: Text("Pensil Staedler Alat Tulis untuk sekolah\nVarian 2B", style: TextStyle(fontSize: 13))),
                      const Text("x1"),
                    ],
                  ),
                  const Align(alignment: Alignment.centerRight, child: Text("Rp.4000")),
                  const Divider(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Total Pesanan: "),
                      Text("Rp.5000", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 4. Tombol Rincian Pembatalan (Tengah)
            ListTile(
              tileColor: Colors.white,
              title: const Text("Butuh Bantuan?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: const Row(
                children: [
                  Icon(Icons.chat_bubble_outline, size: 16),
                  SizedBox(width: 8),
                  Text("Hubungi Toko"),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),

            const SizedBox(height: 12),

            // 5. Detail Pemesanan
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Column(
                children: [
                  _InfoRow(label: "Metode Pembayaran", value: "COD"),
                  _InfoRow(label: "Waktu Pemesanan", value: "15-04-2026 22.00"),
                ],
              ),
            ),
            const SizedBox(height: 80), // Jarak untuk tombol bottom
          ],
        ),
      ),

      // 6. Tombol Bawah (Gambar 4)
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Rincian Pembatalan", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B95DE)),
                child: const Text("Beli Lagi", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(IconData icon, String title, String content) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(content, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          )),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: const TextStyle(color: Colors.grey)), Text(value)],
      ),
    );
  }
}