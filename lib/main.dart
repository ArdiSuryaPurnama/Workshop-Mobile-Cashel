import 'package:flutter/material.dart';
// Pastikan nama paket 'chasel' di bawah ini sama dengan nama di pubspec.yaml kamu

import '../../../../features/auth/presentation/screens/register_page.dart';
import '../../../../features/customer/presentation/screens/detail_produk_screen.dart';
import '../../../../features/auth/presentation/screens/splash_screen.dart';

void main() {runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}