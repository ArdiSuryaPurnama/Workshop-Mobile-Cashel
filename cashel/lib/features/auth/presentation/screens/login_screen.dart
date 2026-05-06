import 'package:chasel/features/auth/presentation/screens/register_page.dart';
// Import halaman detail produk (Sesuaikan path jika folder berbeda)
import 'package:chasel/features/customer/presentation/screens/detail_produk_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'package:chasel/shared/widgets/custom_textfield.dart';

import 'package:http/http.dart' as http;
import 'package:chasel/core/constants/api_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // DI SINI LETAK FUNGSINYA
  Future<void> _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // --- TARUH DI BARIS INI ---
    var url = Uri.parse(ApiConstants.loginEndpoint);
    // --------------------------

    try {
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // ... logika jika berhasil
      } else {
        // ... logika jika gagal
      }
    } catch (e) {
      // ... penanganan error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // IMAGE (Sudah diganti dari Container ke Image.asset)
            // Pastikan file gambar ada di folder assets/ dan sudah di-register di pubspec.yaml
            Image.asset(
              'assets/login-page.png', // Ganti 'logo.png' dengan nama file gambarmu
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                // Jika gambar tidak ditemukan, tampilkan kotak abu-abu agar tidak merah/error
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text("Gambar tidak ditemukan")),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const CustomTextField(hint: "Email"),
            const SizedBox(height: 15),
            const CustomTextField(hint: "Password", isPassword: true),
            
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  // NAVIGASI: Lupa password diarahkan ke RegisterPage sementara
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  );
                },
                child: Text(
                  "Lupa password?",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Masuk",
              onPressed: () {
                // NAVIGASI: Masuk diarahkan ke DetailProdukScreen sementara
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DetailProdukScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            // GARIS ABU-ABU "Atau masuk menggunakan"
            Row(
              children: [
                Expanded(child: Divider(color: Colors.grey[400])),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Atau masuk menggunakan",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey[400])),
              ],
            ),

            const SizedBox(height: 15),

            // Button Google
            InkWell(
              onTap: () {
                print("Tombol Google diklik!");
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, color: Colors.red, size: 40),
                    SizedBox(width: 10),
                    Text("Google", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Button Facebook
            InkWell(
              onTap: () {
                print("Tombol Facebook diklik!");
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: Colors.blue, size: 30),
                    SizedBox(width: 10),
                    Text("Facebook", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? "),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    "Daftar sekarang",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}