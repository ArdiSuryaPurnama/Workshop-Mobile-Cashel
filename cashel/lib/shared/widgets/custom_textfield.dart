import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller; // Tambahkan baris ini

  const CustomTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.controller, // Tambahkan baris ini
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Hubungkan ke controller internal
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}