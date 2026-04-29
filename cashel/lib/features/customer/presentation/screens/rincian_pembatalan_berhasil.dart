import 'package:flutter/material.dart';
import 'hasil_akhir_pembatalan.dart'; // Import untuk halaman terakhir (Gambar 4)

class RincianPembatalanBerhasil extends StatelessWidget {
  const RincianPembatalanBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Rincian Pembatalan", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 1. Header Berhasil (Biru) - Sesuai Gambar 3
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pembatalan Berhasil", 
                      style: TextStyle(color: Color(0xFF3B95DE), fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("pada 16-04-2026 09:14", 
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                const Icon(Icons.check_circle_outline, color: Color(0xFF3B95DE), size: 50),
              ],
            ),
          ),
          
          const SizedBox(height: 10),

          // 2. Info Produk (Singkat)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pensil Staedler Alat Tulis untuk sekolah", 
                        style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text("Varian 2B", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Text("Rp. 4000", style: TextStyle(fontSize: 13)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 3. Detail Pembatalan (Tabel Info)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoRow("Diminta oleh", "Pembeli"),
                _buildInfoRow("Diminta pada", "16-04-2026 09:14"),
                _buildInfoRow("Alasan", "Ingin mengubah rincian & membuat pesanan baru"),
                _buildInfoRow("Metode pembayaran", "QRIS"),
              ],
            ),
          ),

          const Spacer(), // Dorong tombol ke bawah

          // 4. Tombol Rincian Pesanan (Pindah ke Gambar 4)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HasilAkhirPembatalan()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text("Rincian Pesanan", style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget Helper biar tidak nulis Row berkali-kali
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Flexible(
            child: Text(value, 
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}