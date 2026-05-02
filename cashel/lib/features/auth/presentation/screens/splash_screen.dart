import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'login_screen.dart';
import 'register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  // List data untuk 3 halaman onboarding setelah splash biru
  final List<Map<String, String>> data = [
    {
      "title": "CASHEL",
      "desc": "Aplikasi bisnis penjualan Alat Tulis Kantor (ATK) yang bisa dipesan lewat online!",
      "image": "assets/logo_cashel.png" 
    },
    {
      "title": "Mudah dalam pembelian,\ndengan CASHEL",
      "desc": "Pembelian bisa dilakukan secara cod/online agar lebih mudah dan efisien.",
      "image": "assets/onboarding_2.png" 
    },
    {
      "title": "Mudah dalam pembelian,\ndengan CASHEL",
      "desc": "Beli alat tulis sesuai kebutuhan kapan saja",
      "image": "assets/onboarding_3.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Otomatis pindah dari splash biru ke welcome page setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (_controller.hasClients) {
        _controller.animateToPage(1,
            duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) => setState(() => currentPage = index),
        itemCount: data.length + 1,
        itemBuilder: (context, index) {
          // 1. HALAMAN SPLASH BIRU (Index 0)
          if (index == 0) {
            return Container(
              color: AppColors.primary,
              child: const Center(
                child: Text(
                  "EL-FATH",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          // Data untuk halaman 1, 2, 3 onboarding
          final item = data[index - 1];

          // 2. HALAMAN ONBOARDING (DIBUNGKUS SINGLECHILDSCROLLVIEW AGAR TIDAK OVERFLOW)
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    // Gambar Onboarding
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35, // Ukuran dinamis agar tidak overflow
                      child: Image.asset(
                        item["image"]!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.image, size: 100, color: Colors.grey),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      item["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      item["desc"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 30),

                    // Indikator Dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        data.length,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage - 1 == i ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage - 1 == i ? AppColors.primary : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Tombol Navigasi
                    if (index == data.length) 
                      // Halaman Terakhir (Get Started)
                      Column(
                        children: [
                          CustomButton(
                            text: "Masuk",
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage())),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primary),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text("Mendaftar"),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease),
                            child: const Text("Kembali", style: TextStyle(color: Colors.grey)),
                          )
                        ],
                      )
                    else 
                      // Halaman Welcome & Intro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          index > 1 
                            ? TextButton(
                                onPressed: () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                                child: const Text("Kembali", style: TextStyle(color: Colors.grey)),
                              )
                            : const SizedBox(width: 60),
                          TextButton(
                            onPressed: () => _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                            child: const Text("Selanjutnya", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}