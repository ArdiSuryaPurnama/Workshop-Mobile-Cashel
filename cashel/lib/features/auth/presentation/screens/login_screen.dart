import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'package:chasel/shared/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // IMAGE (placeholder)
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            CustomTextField(hint: "Email"),
            const SizedBox(height: 15),
            CustomTextField(hint: "Password", isPassword: true),
            
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Lupa password?",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Masuk",
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            const Text("Atau masuk menggunakan"),

            const SizedBox(height: 15),

            Container(
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
                    const SizedBox(height: 10),

            const SizedBox(height: 15), // Kasih jarak

// --- TOMBOL FACEBOOK MANUAL ---
            Container(
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

            const SizedBox(height: 20),

            const Text("Belum punya akun? Daftar sekarang"),
          ],
        ),
      ),
    );
  }
}