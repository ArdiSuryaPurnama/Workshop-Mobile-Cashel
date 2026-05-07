import 'package:flutter/material.dart';
import 'tampilan_awal_page.dart';   
import 'riwayat_pesanan_page.dart';
import 'notifikasi_page.dart';      
import 'akun.dart';                 

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Warna sesuai desain Figma
  final Color _activeColor = const Color(0xFF0862FD);
  final Color _inactiveColor = Colors.grey;

  final List<Widget> _pages = [
    const TampilanAwalPage(),
    const RiwayatPesananPage(),
    const NotifikasiPage(),
    const AkunPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Pewarnaan teks label
        selectedItemColor: _activeColor,
        unselectedItemColor: _inactiveColor,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
        ),
        items: [
          _buildNavBarItem('assets/images/beranda.png', 'Beranda', 0),
          _buildNavBarItem('assets/images/history.png', 'Riwayat', 1),
          _buildNavBarItem('assets/images/notifikasi.png', 'Notifikasi', 2),
          _buildNavBarItem('assets/images/akun.png', 'Akun', 3),
        ],
      ),
    );
  }

  // Fungsi helper agar icon PNG berubah warna secara otomatis
  BottomNavigationBarItem _buildNavBarItem(String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Image.asset(
          iconPath,
          width: 24,
          // Logika: Jika index ini aktif, pakai warna biru, jika tidak pakai abu-abu
          color: _selectedIndex == index ? _activeColor : _inactiveColor,
        ),
      ),
      label: label,
    );
  }
}