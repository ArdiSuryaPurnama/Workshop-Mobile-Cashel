import 'package:flutter/material.dart';
import 'pilih_alasan_batal.dart';

class RincianPesananScreen extends StatelessWidget {
  final String metodePembayaran;

  const RincianPesananScreen({super.key, required this.metodePembayaran});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Warna background abu-abu tipis
      appBar: AppBar(
        title: const Text(
          "Rincian Pesanan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. BANNER STATUS (BIRU)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              color: const Color(0xFF3B95DE),
              child: const Text(
                "Pesanan sedang disiapkan",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            // 2. INFO PENGIRIMAN
            _buildSection(
              icon: Icons.local_shipping_outlined,
              title: "Info Pengiriman",
              content: "Hemat Kargo - SPX Hemat",
            ),

            const Divider(height: 1),

            // 3. ALAMAT PENGIRIMAN
            _buildSection(
              icon: Icons.location_on_outlined,
              title: "Alamat Pengiriman",
              content: "Jefri Nichol  (+62) 852 1234 8765\nJl A Yani, Kecamatan Nganjuk, Kabupaten Nganjuk, JAWA TIMUR",
            ),

            const SizedBox(height: 15),

            // 4. CARD PRODUK
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(2)),
                        child: const Text("Star+", style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      const SizedBox(width: 8),
                      const Text("CASHEL", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder Gambar Produk
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pensil Staedler Alat Tulis untuk sekolah", maxLines: 2, overflow: TextOverflow.ellipsis),
                            Text("Varian 2B", style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Text("x1"),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Rp.4000"),
                  ),
                  const Divider(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Total Pesanan: "),
                      Text("Rp.5000", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  if (metodePembayaran == "QRIS") 
                    const Align(alignment: Alignment.centerRight, child: Icon(Icons.notifications_none, size: 20)),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 5. BUTUH BANTUAN
            _buildActionTile(
              icon: Icons.chat_bubble_outline,
              title: "Butuh Bantuan?",
              subtitle: "Hubungi Toko",
              onTap: () {
                // Navigasi ke halaman chat/bantuan
              },
            ),

            const SizedBox(height: 15),

            // 6. DETAIL PEMESANAN
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Detail Pemesanan", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildRowDetail("Metode Pembayaran", metodePembayaran),
                  _buildRowDetail("Waktu Pemesanan", "15-04-2026 22.00"),
                ],
              ),
            ),
            const SizedBox(height: 100), // Spasi agar tidak tertutup tombol bawah
          ],
        ),
      ),

      // 7. TOMBOL FIX DI BAWAH
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Biar pop-up-nya bisa tinggi
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const PilihAlasanBatalSheet(), // Memanggil isi pop-up
                      ); // <--- Pastikan ada titik koma di sini
                      },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text("Batalkan Pesanan", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () { /* Fungsi Hubungi Toko */ },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text("Hubungi Toko", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSection({required IconData icon, required String title, required String content}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildRowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value),
        ],
      ),
    );
  }
}