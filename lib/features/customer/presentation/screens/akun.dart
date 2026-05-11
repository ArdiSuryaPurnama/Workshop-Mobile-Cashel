<<<<<<< HEAD
import 'package:cashel/features/auth/presentation/screens/login_screen.dart';
import 'package:cashel/features/customer/presentation/screens/alamat_pengiriman.dart';
import 'package:cashel/features/profile/pesanan_saya_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/akun_widgets.dart'; 

// --- IMPORT HALAMAN TUJUAN (Sesuaikan nama filenya) ---
import 'riwayat_pesanan_page.dart'; 
import 'rincian_pesanan_screen.dart'; // Ini untuk 'Detail Saya'
import 'notifikasi_page.dart';

import '../../../auth/presentation/screens/login_screen.dart';
import 'alamat_pengiriman.dart'; // Buka komen ini kalau file alamat sudah ada

=======
import 'package:flutter/material.dart';
import '../widgets/akun_widgets.dart'; 

>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
<<<<<<< HEAD
=======
  // State data profil
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
  String _userName = "Jefri Nichol";
  String _userEmail = "jefrinichol@gmail.com";
  String _userImage = 'assets/images/profile_pic.png';

<<<<<<< HEAD
  void _showEditNameDialog() {
    TextEditingController nameController = TextEditingController(text: _userName);
=======
  // Fungsi untuk mengganti nama via Pop-up
  void _showEditNameDialog() {
    TextEditingController nameController = TextEditingController(text: _userName);
    
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
<<<<<<< HEAD
        title: const Text("Ubah Nama", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
=======
        title: const Text(
          "Ubah Nama",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nama Lengkap",
<<<<<<< HEAD
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() => _userName = nameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
=======
            hintStyle: const TextStyle(fontFamily: 'Poppins'),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3498DB),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _userName = nameController.text;
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  void _pickImageFromGallery() {
    // Simulasi ganti foto
=======
  // Fungsi untuk akses galeri (Simulasi)
  void _pickImageFromGallery() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 150,
        child: Column(
          children: [
            const Text(
              "Ubah Foto Profil", 
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 18)
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pilih dari Galeri", style: TextStyle(fontFamily: 'Poppins')),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
<<<<<<< HEAD
=======
            // Header menggunakan widget dari akun_widgets.dart
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
            AkunProfileHeader(
              name: _userName,
              email: _userEmail,
              imagePath: _userImage,
              onEditName: _showEditNameDialog,
              onEditPhoto: _pickImageFromGallery,
            ),
            
            const SizedBox(height: 10),
<<<<<<< HEAD

            // --- REVISI MENU ITEMS ---
            
            AkunMenuItem(
              iconPath: 'assets/images/pesanan_icon.png', 
              title: 'Pesanan', 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatPesananPage()));
              }
            ),

            AkunMenuItem(
              iconPath: 'assets/images/detail_saya_icon.png', 
              title: 'Detail Saya', 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailPesananScreen()));
              }
            ),

            AkunMenuItem(
              iconPath: 'assets/images/alamat_icon.png', 
              title: 'Alamat Pengiriman', 
              onTap: () {
                // Ini adalah kode untuk pindah ke halaman alamat
                Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const AlamatSayaPage()),
                );
                },
                ),

            AkunMenuItem(
              iconPath: 'assets/images/notifikasi_icon.png', 
              title: 'Notifikasi', 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiPage()));
              }
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2)),

            const Spacer(flex: 3), 
            
            // --- REVISI LOGOUT ---
            // Karena LogoutButton biasanya stateless widget di file lain, 
            // Kalau kamu mau aksinya ada di sini, kamu bisa bungkus dengan GestureDetector
           const Spacer(flex: 3), 
           GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), 
                (route) => false,
                );
              },
              child: const LogoutButton(),
              ),
              const Spacer(flex: 1),

=======
            // Menu Items
            AkunMenuItem(iconPath: 'assets/images/pesanan_icon.png', title: 'Pesanan', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/detail_saya_icon.png', title: 'Detail Saya', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/alamat_icon.png', title: 'Alamat Pengiriman', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/notifikasi_icon.png', title: 'Notifikasi', onTap: () {}),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2)),

            const Spacer(flex: 3), 
            const LogoutButton(),
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
            const Spacer(flex: 1), 
          ],
        ),
      ),
    );
  }
}