import 'package:flutter/material.dart';
import 'hasil_akhir_pembatalan.dart';

class RincianPembatalanBerhasil extends StatelessWidget {
  const RincianPembatalanBerhasil({Key? key}) : super(key: key);

  // Fungsi pembantu untuk memformat waktu saat ini secara real-time
  String _getFormattedCurrentDate() {
    final now = DateTime.now();
    
    // Format hari/bulan/tahun dua digit agar rapi (DD-MM-YYYY)
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();
    
    // Format jam dan menit (HH:mm)
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    
    return "$day-$month-$year $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    // Kita panggil fungsi tanggal saat ini agar dinamis setiap kali halaman dibuka
    final String tanggalSaatIni = _getFormattedCurrentDate();

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
          "Rincian Pembatalan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ==========================================
          // 1. HEADER DENGAN LATAR BELAKANG BIRU
          // ==========================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            color: const Color(0xFF3B95DE), // Biru Cashel khas aplikasimu
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pembatalan Berhasil",
                        style: TextStyle(
                          color: Colors.white, // Teks putih agar kontras
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "pada $tanggalSaatIni", // 2. TANGGAL REAL-TIME SEPERTI REQUESTMU
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9), // Putih soft
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Ikon centang diubah ke warna putih agar selaras dengan latar biru
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF3B95DE),
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          // --- SISA DETAIL KONTEN BAWAH ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item Pesanan Batal
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image, color: Colors.grey, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pensil Staedler Alat Tulis untuk sekolah",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Varian 2B",
                              style: TextStyle(color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Rp. 4000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Informasi Detail
                  _buildDetailRow("Diminta oleh", "Pembeli"),
                  const SizedBox(height: 12),
                  _buildDetailRow("Diminta pada", tanggalSaatIni),
                  const SizedBox(height: 12),
                  _buildDetailRow("Alasan", "Ingin mengubah rincian & membuat pesanan baru"),
                  const SizedBox(height: 12),
                  _buildDetailRow("Metode pembayaran", "QRIS"),
                ],
              ),
            ),
          ),

          // --- TOMBOL DI PALING BAWAH ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // Silakan dihubungkan ke halaman berikutnya di sini jika diperlukan
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Membuat tombol lonjong melengkung
                  ),
                ),
                child: const Text(
                  "Rincian Pesanan",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk baris detail rincian
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}