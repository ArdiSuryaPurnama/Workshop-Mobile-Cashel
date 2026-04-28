import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> data = [
    {
      "title": "CASHEL",
      "desc": "Aplikasi bisnis penjualan ATK yang bisa dipesan lewat online!"
    },
    {
      "title": "Mudah dalam pembelian",
      "desc": "Pembelian bisa dilakukan secara online agar lebih mudah"
    },
    {
      "title": "Mudah dalam pembelian",
      "desc": "Beli alat tulis sesuai kebutuhan kapan saja"
    },
  ];

  @override
  void initState() {
    super.initState();

    // splash awal (biru)
    Future.delayed(const Duration(seconds: 2), () {
    if (_controller.hasClients) {
      _controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
        itemCount: data.length + 1,
        itemBuilder: (context, index) {
          // SPLASH AWAL (biru)
          if (index == 0) {
            return Container(
              color: AppColors.primary,
              child: const Center(
                child: Text(
                  "EL-FATH",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          final item = data[index - 1];

          // ONBOARDING
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // gambar placeholder
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  item["title"]!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Text(
                  item["desc"]!,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // indikator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    data.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage - 1 == i ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentPage - 1 == i
                            ? AppColors.primary
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // tombol terakhir
                if (index == data.length)
                  Column(
                    children: [
                      CustomButton(
                        text: "Masuk",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text("Mendaftar"),
                      ),
                    ],
                  )
                else
                  TextButton(
                    onPressed: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: const Text("Selanjutnya"),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}