import 'package:flutter/material.dart';

class AlamatSayaPage extends StatelessWidget {
  const AlamatSayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Warna background soft gray
      appBar: AppBar(
        title: const Text("Alamat Pengiriman", 
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // KARTU ALAMAT
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E2E2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Pin Lokasi
                  const Icon(Icons.location_on, color: Color(0xFF3498DB), size: 28),
                  const SizedBox(width: 12),
                  
                  // Detail Teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Jefri Nichol",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "(+62) 852 1234 8765",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Jl A Yani, Kecamatan Nganjuk, Kabupaten Nganjuk, JAWA TIMUR",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF4A4A4A),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Label Alamat Utama (Opsional)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Utama",
                            style: TextStyle(
                              color: Color(0xFF3498DB),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Icon Edit
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_note, color: Colors.grey),
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