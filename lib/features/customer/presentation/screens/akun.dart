import 'package:flutter/material.dart';
import '../widgets/akun_widgets.dart'; 

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  // State data profil
  String _userName = "Jefri Nichol";
  String _userEmail = "jefrinichol@gmail.com";
  String _userImage = 'assets/images/profile_pic.png';

  // Fungsi untuk mengganti nama via Pop-up
  void _showEditNameDialog() {
    TextEditingController nameController = TextEditingController(text: _userName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Ubah Nama",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nama Lengkap",
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
          ),
        ],
      ),
    );
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header menggunakan widget dari akun_widgets.dart
            AkunProfileHeader(
              name: _userName,
              email: _userEmail,
              imagePath: _userImage,
              onEditName: _showEditNameDialog,
              onEditPhoto: _pickImageFromGallery,
            ),
            
            const SizedBox(height: 10),
            // Menu Items
            AkunMenuItem(iconPath: 'assets/images/pesanan_icon.png', title: 'Pesanan', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/detail_saya_icon.png', title: 'Detail Saya', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/alamat_icon.png', title: 'Alamat Pengiriman', onTap: () {}),
            AkunMenuItem(iconPath: 'assets/images/notifikasi_icon.png', title: 'Notifikasi', onTap: () {}),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2)),

            const Spacer(flex: 3), 
            const LogoutButton(),
            const Spacer(flex: 1), 
          ],
        ),
      ),
    );
  }
}