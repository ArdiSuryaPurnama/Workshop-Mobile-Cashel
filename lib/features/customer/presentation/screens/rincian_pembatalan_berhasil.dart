import 'package:flutter/material.dart';
import 'hasil_akhir_pembatalan.dart'; // Import tetap ada sesuai permintaan

class RincianPembatalanBerhasil extends StatelessWidget {
  final String namaProduk;
  final String imagePath;
  final int jumlah;
  final int harga;
  final String alasan;
  final String waktuBatal;

  const RincianPembatalanBerhasil({
    super.key,
    required this.namaProduk,
    required this.imagePath,
    required this.jumlah,
    required this.harga,
    required this.alasan,
    required this.waktuBatal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Rincian Pembatalan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Status (Biru Cerah Figma)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFF3498DB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pembatalan Berhasil",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "pada $waktuBatal",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.assignment_turned_in_outlined, color: Colors.white, size: 42),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(color: Colors.grey[200], width: 60, height: 60),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                namaProduk,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'Poppins'),
                              ),
                              Text(
                                "x$jumlah",
                                style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Poppins'),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Rp$harga",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(thickness: 0.5),
                    ),
                    _buildInfoRow("Alasan Pembatalan", alasan),
                    _buildInfoRow("Diminta Oleh", "Pembeli"),
                    _buildInfoRow("Waktu Pembatalan", waktuBatal),
                  ],
                ),
              ),
            ),
          ),

          // Tombol Rincian Pesanan (Navigasi ke Hasil Akhir)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Rincian Pesanan",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),

          // Tombol Kembali
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3498DB),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Text(
                  "Kembali",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'Poppins')),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}