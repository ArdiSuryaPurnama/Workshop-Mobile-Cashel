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

  void handleLogin() async {
    setState(() => isLoading = true);

    try {
      LoginService authService = LoginService();
      UserModel response = await authService.login(
        emailController.text,
        passwordController.text,
      );

      setState(() => isLoading = false);

      if (response.status == 'success') {
        if (response.data!.role == 'admin') {
          // Navigasi ke Dashboard Admin (Ganti dengan class Admin kamu nanti)
          print("Masuk sebagai Admin");
        } else {
          // Navigasi ke Dashboard Customer
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DetailProdukScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
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
            Image.asset(
              'assets/login-page.png',
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text("Gambar tidak ditemukan")),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            CustomTextField(hint: "Email", controller: emailController),
            const SizedBox(height: 15),
            CustomTextField(hint: "Password", isPassword: true, controller: passwordController),
            
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage())),
                child: Text("Lupa password?", style: TextStyle(color: Colors.grey[600])),
              ),
            ),
            const SizedBox(height: 20),

            isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  text: "Masuk",
                  onPressed: handleLogin,
                ),

            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Belum punya akun? "),
                InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage())),
                  child: const Text(
                    "Daftar sekarang",
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
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