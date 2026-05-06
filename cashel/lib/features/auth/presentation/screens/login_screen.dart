import 'package:chasel/features/auth/presentation/screens/register_page.dart';
import 'package:chasel/features/customer/presentation/screens/detail_produk_screen.dart';
import '../../../../data/service/login_service.dart';
import '../../../../data/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'package:chasel/shared/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage; // Variabel untuk menyimpan pesan error di atas

  void handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Reset error setiap kali mencoba login
    });

    try {
      LoginService authService = LoginService();
      UserModel response = await authService.login(
        emailController.text,
        passwordController.text,
      );

      setState(() => isLoading = false);

      if (response.status == 'success') {
        if (response.data!.role == 'admin') {
          print("Masuk sebagai Admin");
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DetailProdukScreen()),
          );
        }
      } else {
        // Tampilkan error di bagian atas
        setState(() => errorMessage = "Harap Periksa kembali Email atau Password yang anda masukkan!!!");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Terjadi kesalahan koneksi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // --- 1. ERROR BANNER (MUNCUL DI PALING ATAS) ---
              if (errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE57373), // Warna merah sesuai gambar
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),

              const SizedBox(height: 40),
              Image.asset(
                'assets/login-page.png',
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),

              CustomTextField(hint: "Email", controller: emailController),
              const SizedBox(height: 15),
              CustomTextField(hint: "Password", isPassword: true, controller: passwordController),
              
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {}, // Tambahkan navigasi lupa password jika ada
                  child: const Text("Lupa password?", style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 25),

              isLoading
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: "Masuk",
                    onPressed: handleLogin,
                  ),

              const SizedBox(height: 30),

              // --- 2. DIVIDER "ATAU MASUK MENGGUNAKAN" ---
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Atau masuk menggunakan", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ),
                  const Expanded(child: Divider(thickness: 1.5)),
                ],
              ),
              
              const SizedBox(height: 25),

              // --- 3. SOCIAL BUTTONS ---
              _buildSocialButton(
                text: "Google",
                iconAsset: 'assets/google-icon.png',
                borderColor: Colors.redAccent,
                textColor: Colors.redAccent,
              ),
              const SizedBox(height: 15),
              _buildSocialButton(
                text: "Facebook",
                iconAsset: 'assets/facebook-icon.png',
                borderColor: const Color(0xFF3B95DE),
                textColor: const Color(0xFF3B95DE),
              ),

              const SizedBox(height: 30),
              
              // --- 4. REDIRECT DAFTAR ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun? "),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                    child: const Text(
                      "Mendaftar sekarang",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk tombol Social Login
  Widget _buildSocialButton({
    required String text,
    required String iconAsset,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Logika login social nanti di sini
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconAsset, height: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}