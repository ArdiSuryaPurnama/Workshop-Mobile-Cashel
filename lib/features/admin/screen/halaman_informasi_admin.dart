import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // <--- Pastikan import image_picker sudah ada
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/auth/presentation/screens/login_screen.dart'; // Sesuaikan path ini dengan projectmu

class HalamanInformasiAdmin extends StatefulWidget {
  const HalamanInformasiAdmin({super.key});

  @override
  State<HalamanInformasiAdmin> createState() => _HalamanInformasiAdminState();
}

class _HalamanInformasiAdminState extends State<HalamanInformasiAdmin> {
  String namaAdmin = "Memuat...";
  String emailAdmin = "Memuat...";
  
  // Variabel untuk menyimpan nama file foto profil yang dipilih
  String _fotoProfilTerpilih = ""; 

  @override
  void initState() {
    super.initState();
    loadSessionAdmin();
  }

  Future<void> loadSessionAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaAdmin = prefs.getString('nama_user') ?? "Admin Cashel";
      emailAdmin = prefs.getString('email_user') ?? "admin@cashel.com";
      // Mengambil foto profil lama jika pernah disimpan di lokal, jika tidak kosongkan
      _fotoProfilTerpilih = prefs.getString('foto_profil_admin') ?? "";
    });
  }

  // Fungsi memicu kamera/galeri untuk mengubah foto profil admin
  Future<void> _ubahFotoProfil() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _fotoProfilTerpilih = image.name;
      });
      // Simpan nama file foto profil ke memori lokal HP agar tidak hilang saat aplikasi direstart
      await prefs.setString('foto_profil_admin', image.name);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Foto profil diperbarui: ${image.name}")),
      );
    }
  }

  Future<void> prosesLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. MENGUBAH BACKGROUND UTAMANYA MENJADI PUTIH BERSIH
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // 2. MENGHAPUS TOMBOL PANAH KEMBALI (leading dihapus agar tidak navigasi ke halaman kosong)
        leading: null, 
        automaticallyImplyLeading: false, // Memastikan tombol back bawaan tidak muncul otomatis
        title: const Text(
          "Informasi Admin",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false, // Rata kiri sesuai kustomisasi sebelumnya
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black, size: 30),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // 3. AREA FOTO PROFIL KOSONG DENGAN OVERLAY TOMBOL PENSIL DINAMIS
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF5F5F5), // Background abu-abu kosong minimalis
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        70,
                      ), // Membuat isi container dipotong bulat sempurna
                      child: _fotoProfilTerpilih.isNotEmpty
                          // Jika user sudah memilih foto, tampilkan fotonya dari asset
                          ? Image.asset(
                              'assets/images/$_fotoProfilTerpilih',
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.grey,
                              ),
                            )
                          // Jika belum ada/kosong, tampilkan icon person abu-abu polos biasa
                          : const Icon(
                              Icons.person,
                              size: 70,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  // Tombol Bulat Ikon Pensil di Pojok Kanan Bawah
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _ubahFotoProfil, // Memicu fungsi image picker galeri
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(0xFF2196F3), // Biru figma
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Card Serial Admin
            _buildCustomCard(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Serial Admin", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                  Text("#AD1108", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Card Detail Biodata (Nama, Email, Alamat Ber-border tipis abu)
            _buildCustomCard(
              child: Column(
                children: [
                  _buildBioRow("Nama", namaAdmin),
                  const Divider(thickness: 1, height: 20),
                  _buildBioRow("Email", emailAdmin),
                  const Divider(thickness: 1, height: 20),
                  _buildBioRow(
                    "Alamat", 
                    "Jl. Panglima Sudirman, Mangundikaran, Kec. Nganjuk, Kabupaten Nganjuk, Jawa Timur 64419",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Card Tanggal Registrasi
            _buildCustomCard(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tanggal registrasi", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                  Text("2 Maret 2024", style: TextStyle(color: Colors.black87, fontSize: 15)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Card Catatan
            _buildCustomCard(
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("Catatan", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 40),

            // Tombol Log Out
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: prosesLogOut,
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBioRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        // Menambahkan garis tepi abu-abu tipis agar senada dengan halaman stok produk
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: child,
    );
  }
}