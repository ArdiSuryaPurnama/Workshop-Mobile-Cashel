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

            // IMAGE (placeholder dulu biar ga error)
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

            OutlinedButton(
              onPressed: () {},
              child: const Text("Google"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () {},
              child: const Text("Facebook"),
            ),

            const SizedBox(height: 20),

            const Text("Belum punya akun? Daftar sekarang"),
          ],
        ),
      ),
    );
  }
}