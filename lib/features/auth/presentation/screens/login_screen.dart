import 'package:flutter/material.dart';
import '../../../../features/admin/screen/admin_main_screen.dart';
import '.././screens/register_page.dart';
import '../../../../features/customer/presentation/screens/detail_produk_screen.dart';
import '../../../../data/service/login_service.dart';
import '../../../../data/models/user_model.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../features/customer/presentation/screens/tampilan_awal_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _isObscure = true;
  String? errorMessage;

  // FUNGSI LOGIN VIA PHP
  void handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      LoginService authService = LoginService();
      UserModel response = await authService.login(
        emailController.text,
        passwordController.text,
      );

      // Cek apakah widget masih terpasang sebelum setState
      if (!mounted) return;

      setState(() => isLoading = false);

      if (response.status == 'success') {
        String userRole = response.data?.role ?? 'customer';

        if (userRole == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminMainScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const TampilanAwalPage()),
          );
        }
      } else {
        setState(() => errorMessage = response.message.isNotEmpty 
          ? response.message 
          : "Harap Periksa kembali Email atau Password yang anda masukkan!!!");
      }
    } catch (e) {
      if (!mounted) return;
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
              if (errorMessage != null)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE57373),
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
                'assets/images/register.png',
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),

              CustomTextField(
                hint: "Email",
                controller: emailController,
              ),

              const SizedBox(height: 15),

              CustomTextField(
                hint: "Password",
                controller: passwordController,
                isPassword: _isObscure,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
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

              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Atau masuk menggunakan", 
                      style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  ),
                  const Expanded(child: Divider(thickness: 1.5)),
                ],
              ),

              const SizedBox(height: 25),

              _buildSocialButton(
                text: "Google",
                iconAsset: 'assets/images/google-icon.png',
                borderColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: () {
                  // Tambahkan logika Login Google via PHP di sini nanti
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login Google via PHP belum diimplementasikan"))
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildSocialButton(
                text: "Facebook",
                iconAsset: 'assets/images/facebook-icon.png',
                borderColor: const Color(0xFF3B95DE),
                textColor: const Color(0xFF3B95DE),
                onTap: () {
                  // Tambahkan logika Login Facebook via PHP di sini nanti
                },
              ),

              const SizedBox(height: 30),

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

  Widget _buildSocialButton({
    required String text,
    required String iconAsset,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
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