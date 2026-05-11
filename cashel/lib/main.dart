<<<<<<< HEAD
import 'package:flutter/material.dart';
// Pastikan nama paket 'chasel' di bawah ini sama dengan nama di pubspec.yaml kamu
import 'package:chasel/features/auth/presentation/screens/register_page.dart';
import 'package:chasel/features/customer/presentation/screens/detail_produk_screen.dart';
import 'package:chasel/features/auth/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: SplashScreen(),
    );
  }
=======
import 'package:flutter/material.dart';
// Pastikan nama paket 'chasel' di bawah ini sama dengan nama di pubspec.yaml kamu
import 'package:chasel/features/auth/presentation/screens/register_page.dart';
import 'package:chasel/features/customer/presentation/screens/detail_produk_screen.dart';
import 'package:chasel/features/auth/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: SplashScreen(),
    );
  }
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
}