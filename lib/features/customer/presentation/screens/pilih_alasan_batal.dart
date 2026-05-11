import 'package:flutter/material.dart';

class PilihAlasanBatalPage extends StatefulWidget {
  const PilihAlasanBatalPage({super.key});

  @override
  State<PilihAlasanBatalPage> createState() => _PilihAlasanBatalPageState();
}

class _PilihAlasanBatalPageState extends State<PilihAlasanBatalPage> {
  String? alasanTerpilih;

  final List<String> daftarAlasan = [
    "Ingin mengubah alamat pengiriman",
    "Ingin mengubah rincian pesanan",
    "Menemukan harga yang lebih murah",
    "Lainnya",
  ];

  @override
  Widget build(BuildContext context) {
    // Menggunakan Scaffold agar bisa tampil sebagai halaman penuh atau navigasi normal
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          "Pilih Alasan Pembatalan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: daftarAlasan.map((alasan) => _buildRadioOption(alasan)).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: alasanTerpilih == null
                    ? null
                    : () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Pesanan berhasil dibatalkan"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3498DB),
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Konfirmasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return RadioListTile<String>(
      title: Text(
        value,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
      ),
      value: value,
      groupValue: alasanTerpilih,
      activeColor: const Color(0xFF3498DB),
      contentPadding: EdgeInsets.zero,
      onChanged: (String? val) {
        setState(() {
          alasanTerpilih = val;
        });
      },
    );
  }
}