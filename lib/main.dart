import 'package:cashel/features/customer/presentation/widgets/tampilan_awal_widgets.dart';
import 'package:flutter/material.dart';
// Pastikan nama paket 'chasel' di bawah ini sama dengan nama di pubspec.yaml kamu
import 'package:cashel/features/auth/presentation/screens/register_page.dart';
import 'package:cashel/features/customer/presentation/screens/detail_produk_screen.dart';
import 'package:cashel/features/auth/presentation/screens/splash_screen.dart';
import 'package:cashel/features/customer/presentation/screens/tampilan_awal_page.dart';

void main() {
  runApp(const MyApp());
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
      home: TampilanAwalPage(),
    );
  }
}