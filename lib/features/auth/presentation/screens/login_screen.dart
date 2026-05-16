import 'dart:convert'; // Untuk men-decode respon JSON API
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // <---
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Untuk session data lokal

// Import screen & features sesuai struktur project kamu
import '../../../../features/admin/screen/admin_main_screen.dart';
import '.././screens/register_page.dart';
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

  // ===========================================================================
  // 1. FITUR LOGIN VIA GOOGLE SIGN-IN (FIXED: SELALU COCOK DENGAN SELEKSI ROLE & EMAIL)
  // ===========================================================================
  Future<void> signInWithGoogle() async {
    try {
      // -----------------------------------------------------------------------
      // Ini bertugas memutuskan auto-login agar jendela pilih akun selalu keluar
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      // -----------------------------------------------------------------------

      GoogleAuthProvider authProvider = GoogleAuthProvider();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(authProvider);

      User? user = userCredential.user;

      if (user != null) {
        // Mengirim data identitas google ke backend untuk dicek/didaftarkan ke DB
        final response = await http.post(
          Uri.parse("http://localhost/api_cashel/auth/google_login.php"),
          body: {
            "nama": user.displayName ?? "",
            "email": user.email ?? "",
            "uid": user.uid,
          },
        );

        if (!mounted) return;

        // Mendecode data respon dari script google_login.php
        final dataRespon = json.decode(response.body);

        if (dataRespon['status'] == 'success') {
          
          // --- PROSES MENYIMPAN SESSION AKUN GOOGLE KE LOKAL HP ---
          SharedPreferences prefs = await SharedPreferences.getInstance();
          
          String namaUser = dataRespon['data']['nama'] ?? (user.displayName ?? 'User Cashel');
          String roleUser = dataRespon['data']['role'] ?? 'customer';

          await prefs.setString('nama_user', namaUser);
          await prefs.setString('email_user', user.email ?? "");
          await prefs.setString('role_user', roleUser);
          await prefs.setBool('is_login', true);
          // -------------------------------------------------------------

          // Menampilkan snackbar pemberitahuan sukses
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Login via Google berhasil!"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              duration: const Duration(seconds: 2),
            ),
          );

          // PENGALIHAN HALAMAN BERDASARKAN ROLE DATA GOOGLE DI DATABASE SECARA RIIL
          if (roleUser == 'admin') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const AdminMainScreen()),
              (route) => false, // Bersihkan history halaman agar aman dari tombol back
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const TampilanAwalPage()),
              (route) => false,
            );
          }
        } else {
          // Jika status balikan dari API php bernilai error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Gagal verifikasi database server: ${dataRespon['message']}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google Sign-In gagal: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
        ),
      );
    }
  }

  // ===========================================================================
  // 2. FITUR LOGIN MANUAL PHP MYSQL VIA FORM INPUT
  // ===========================================================================
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

      if (!mounted) return;

      setState(() => isLoading = false);

      if (response.status == 'success') {
        
        // --- PROSES MENYIMPAN SESSION AKUN MANUAL KE LOKAL HP ---
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        await prefs.setString('nama_user', response.data?.nama ?? 'Admin Cashel');
        await prefs.setString('email_user', emailController.text); 
        await prefs.setString('role_user', response.data?.role ?? 'admin');
        await prefs.setBool('is_login', true);
        // --------------------------------------------------------

        String userRole = response.data?.role ?? 'customer';

        if (userRole == 'admin') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AdminMainScreen()),
            (route) => false, 
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const TampilanAwalPage()),
          );
        }
      } else {
        setState(() {
          errorMessage = response.message.isNotEmpty ? response.message : "Email atau Password salah!";
        });
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
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
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
                  onPressed: () => setState(() => _isObscure = !_isObscure),
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
                  : CustomButton(text: "Masuk", onPressed: handleLogin),

              const SizedBox(height: 30),
              _buildDivider(),
              const SizedBox(height: 25),

              // TOMBOL SOSIAL MEDIA GOOGLE SIGN-IN
              _buildSocialButton(
                text: "Google",
                iconAsset: 'assets/images/google-icon.png',
                borderColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: () async => await signInWithGoogle(),
              ),

              const SizedBox(height: 30),
              _buildRegisterRedirect(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // WIDGET HELPERS COMPONENT UI
  // ===========================================================================
  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Atau masuk menggunakan",
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ),
        const Expanded(child: Divider(thickness: 1.5)),
      ],
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

  Widget _buildRegisterRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum punya akun? "),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterPage()),
            );
          },
          child: const Text(
            "Mendaftar sekarang",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}