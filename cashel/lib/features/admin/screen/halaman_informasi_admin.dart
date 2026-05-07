import 'package:flutter/material.dart';

class ProfilAdminScreen extends StatefulWidget {
  const ProfilAdminScreen({super.key});

  @override
  State<ProfilAdminScreen> createState() => _ProfilAdminScreenState();
}

class _ProfilAdminScreenState extends State<ProfilAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background pink muda sesuai Figma
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informasi Admin',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- FOTO PROFIL ---
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  image: const DecorationImage(
                    image: AssetImage('images/admin_profile.jpg'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- 1. CARD SERIAL ADMIN ---
            const InformasiPenggunaCard(
              label: 'Serial Admin', 
              value: '#AD1108', 
              isBold: true
            ),
            
            // --- 2. GRUP INFORMASI (NAMA, EMAIL, ALAMAT) ---
            // Kontainer ini sekarang menggunakan dekorasi yang sama dengan InformasiPenggunaCard
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow serupa
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildInternalRow('Nama', 'Karang Keanu'),
                  const Divider(height: 1),
                  _buildInternalRow('Email', 'karang@gmail.com'),
                  const Divider(height: 1),
                  _buildInternalRow('Alamat', 'Jl. Panglima Sudirman, Mangundikaran, Nganjuk, Jawa Timur 64419'),
                ],
              ),
            ),
            
            // --- 3. CARD TANGGAL & CATATAN ---
            const InformasiPenggunaCard(
              label: 'Tanggal registrasi', 
              value: '2 Maret 2024'
            ),
            
            const SizedBox(height: 30),

            // --- TOMBOL LOGOUT ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF3498DB),
                  elevation: 2,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  // Tambahkan Navigator.pushAndRemoveUntil ke Login disini
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget untuk baris di dalam grup kontainer putih
  Widget _buildInternalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value, 
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// --- KOMPONEN CARD UTAMA (Sesuai Struktur Anda) ---
class InformasiPenggunaCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const InformasiPenggunaCard({
    super.key, 
    required this.label, 
    required this.value, 
    this.isBold = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Efek bayangan halus
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14)),
          Text(
            value, 
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: Colors.black,
            )
          ),
        ],
      ),
    );
  }
}
