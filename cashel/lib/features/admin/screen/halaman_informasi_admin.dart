import 'package:flutter/material.dart';
import '../../../features/admin/widgets/custom_bottom.dart';
// Import halaman lain jika diperlukan untuk navigasi balik
import '../../../features/admin/screen/halaman_list_order.dart'; 

class ProfilAdminScreen extends StatefulWidget {
  const ProfilAdminScreen({super.key});

  @override
  State<ProfilAdminScreen> createState() => _ProfilAdminScreenState();
}

class _ProfilAdminScreenState extends State<ProfilAdminScreen> {
  // Samakan dengan index menu Akun (Index 4)
  int _selectedIndex = 4; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Informasi Admin',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- BAGIAN GAMBAR PROFIL LINGKARAN ---
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF2F3F2),
                      image: const DecorationImage(
                        image: AssetImage('images/admin_profile.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '#AD1108',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),

            // --- BAGIAN DETAIL INFORMASI ---
            _buildInfoTile('Nama', 'Admin Cashel'),
            const Divider(),
            _buildInfoTile('Email', 'admin123@gmail.com'),
            const Divider(),
            _buildInfoTile('Alamat', 'Jl. Panglima Sudirman, Mangundikaran, Kec. Nganjuk, Kabupaten Nganjuk, Jawa Timur 64419'),
            const Divider(),
            _buildInfoTile('Tanggal Registrasi', '2 Maret 2024'),
            
            const SizedBox(height: 40),

            // --- TOMBOL LOGOUT ---
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2F3F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Logika Logout
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xFF3498DB),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // --- MENGGUNAKAN BOTTOM BAR YANG SAMA DENGAN LIST ORDER ---
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Logika navigasi yang sama
          if (index == 2) { // Jika klik List Order
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HalamanListOrder()),
            );
          }
          // Tambahkan logika index lainnya (0, 1, 3) di sini sesuai kebutuhan
        },
      ),
    );
  }

  // Helper Widget untuk baris informasi
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
