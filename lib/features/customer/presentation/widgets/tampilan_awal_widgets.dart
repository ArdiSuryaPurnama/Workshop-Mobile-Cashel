import 'package:flutter/material.dart';

// Import ke folder screens (naik satu tingkat) untuk navigasi
import '../screens/halaman_grosir.dart';
import '../screens/akun.dart';
import '../screens/semua_produk.dart';

// Import sesama file di folder widgets
import 'grosir_card.dart';
import 'produk_card.dart';

class TampilanAwalWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Widget bodyContent;

  const TampilanAwalWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.bodyContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0862FD),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/beranda.png', 
              width: 24, 
              color: selectedIndex == 0 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/history.png', 
              width: 24, 
              color: selectedIndex == 1 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Jelajah',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/notifikasi.png', 
              width: 24, 
              color: selectedIndex == 2 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/akun.png', 
              width: 24, 
              color: selectedIndex == 3 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}