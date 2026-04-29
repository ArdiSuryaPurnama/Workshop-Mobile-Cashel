import 'package:flutter/material.dart';
import 'rincian_pembatalan_berhasil.dart'; // Aktifkan kalau file rincian pembatalan sudah dibuat

class PilihAlasanBatalSheet extends StatefulWidget {
  const PilihAlasanBatalSheet({super.key});

  @override
  State<PilihAlasanBatalSheet> createState() => _PilihAlasanBatalSheetState();
}

class _PilihAlasanBatalSheetState extends State<PilihAlasanBatalSheet> {
  // Variabel untuk menyimpan alasan yang dipilih
  String? alasanTerpilih;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding agar isi tidak nempel ke pinggir layar
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Biar tinggi pop-up pas sama isi
        children: [
          // Header: Judul dan Tombol Close (X)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Pilih Alasan Pembatalan", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Icon(Icons.close)
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 1. Box Notifikasi Kuning (Sesuai Gambar 1)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDE7), // Kuning muda
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notifications, color: Colors.orange, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Mohon pilih alasan pembatalan. Pesananmu akan langsung dibatalkan setelah alasan pembatalan diajukan.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 2. Daftar Alasan (Radio Button)
          _buildRadioOption("Ingin mengubah rincian & membuat pesanan baru"),
          _buildRadioOption("Toko tidak membalas chat"),
          _buildRadioOption("Tidak memerlukan barang ini"),
          _buildRadioOption("Alasan lainnya"),

          const SizedBox(height: 20),

          // 3. Tombol Konfirmasi (Gambar 2)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: alasanTerpilih == null 
                ? null // Tombol mati kalau belum pilih
                : () {
                    Navigator.pop(context); // Tutup Pop-up
                    print("Alasan dipilih: $alasanTerpilih");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RincianPembatalanBerhasil()));
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: alasanTerpilih == null 
                  ? Colors.grey[300] // Abu-abu kalau mati
                  : const Color(0xFF3B95DE), // Biru kalau aktif
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Konfirmasi"),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi helper untuk bikin baris pilihan radio
  Widget _buildRadioOption(String value) {
    return RadioListTile<String>(
      title: Text(value, style: const TextStyle(fontSize: 14)),
      value: value,
      groupValue: alasanTerpilih,
      activeColor: const Color(0xFF3B95DE),
      onChanged: (String? val) {
        setState(() {
          alasanTerpilih = val;
        });
      },
    );
  }
}