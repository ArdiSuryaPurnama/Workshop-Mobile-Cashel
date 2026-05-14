import 'package:flutter/material.dart';
import '../widgets/akun_widgets.dart'; 

// --- IMPORT HALAMAN TUJUAN (Pastikan file-file ini ada di folder yang sama) ---
import 'riwayat_pesanan_page.dart'; 
import 'rincian_pesanan_screen.dart'; 
import 'notifikasi_page.dart';
import 'alamat_pengiriman.dart'; 

// Import Login (Gunakan salah satu path yang benar)
import 'package:cashel/features/auth/presentation/screens/Splash_screen.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  String _userName = "Jefri Nichol";
  String _userEmail = "jefrinichol@gmail.com";
  String _userImage = 'assets/images/profile_pic.jpeg';

  void _showEditNameDialog() {
    TextEditingController nameController = TextEditingController(text: _userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Ubah Nama", style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nama Lengkap",
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
          ),
        ],
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
            AkunProfileHeader(
              name: _userName,
              email: _userEmail,
              imagePath: _userImage,
              // 1. Ini fungsi ketika KOTAK PROFIL diklik (Edit Akun)
              onEditName: () {
                _showEditNameDialog(); // Panggil fungsi dialog yang sudah kamu buat
                },
                // 2. Ini fungsi ketika LOGO KAMERA diklik (Ganti Foto)
                onEditPhoto: () {
                  // Sementara kita kasih notifikasi dulu
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Membuka Galeri...")),
                    );
                    void _pickImageFromGallery() {
                      // Sementara kita kasih notifikasi dulu ya
                      //// Nanti kalau mau beneran ambil foto, kita harus instal 'image_picker'
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Fitur akses galeri sedang disiapkan!"),
                          backgroundColor: Colors.blue,
                          ),
                          );
                        }
                      },
                    ),
            
            const SizedBox(height: 10),

            AkunMenuItem(
              iconPath: 'assets/images/pesanan_icon.png', 
              title: 'Pesanan', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatPesananPage())),
            ),

            AkunMenuItem(
              iconPath: 'assets/images/detail_saya_icon.png', 
              title: 'Detail Saya', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatPesananPage())),
            ),

            AkunMenuItem(
              iconPath: 'assets/images/alamat_icon.png', 
              title: 'Alamat Pengiriman', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AlamatSayaPage())),
            ),

            AkunMenuItem(
              iconPath: 'assets/images/notifikasi_icon.png', 
              title: 'Notifikasi', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifikasiPage())),
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE2E2E2)),

            const Spacer(flex: 3), 
            
            GestureDetector(
              onTap: () {
                // Logout ke SplashScreen (atau LoginScreen sesuai kemauanmu)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()), 
                  (route) => false,
                );
              },
              child: const LogoutButton(),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}