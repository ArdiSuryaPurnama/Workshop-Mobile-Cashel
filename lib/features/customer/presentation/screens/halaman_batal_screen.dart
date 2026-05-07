import 'package:flutter/material.dart';

class HalamanBatalScreen extends StatelessWidget {
  const HalamanBatalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Batalkan Pesanan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.remove_circle_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text("Apakah Anda yakin ingin membatalkan pesanan?"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Kembali"),
            )
          ],
        ),
      ),
    );
  }
}