import 'package:flutter/material.dart';

class TampilanAwalWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Widget bodyContent;
  final double scale;
  final bool isScrolled;
  final Widget keranjangBadge;
  final VoidCallback onSearchTap;

  const TampilanAwalWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.bodyContent,
    required this.scale,
    required this.isScrolled,
    required this.keranjangBadge,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Header hanya muncul jika bukan di halaman Akun (index 3)
      appBar: selectedIndex == 3
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(110 * scale),
              child: _buildFixedTopBar(),
            ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0862FD),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w600),
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
            label: 'Riwayat',
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

  Widget _buildFixedTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: isScrolled
            ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]
            : [],
      ),
      child: Stack(
        children: [
          // Background Image Header
          Container(
            height: 130 * scale,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/top_bar.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Search Bar & Keranjang
          Padding(
            padding: EdgeInsets.fromLTRB(20 * scale, 50 * scale, 20 * scale, 15 * scale),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onSearchTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(15 * scale),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF181B19)),
                          SizedBox(width: 10 * scale),
                          Text(
                            "Cari",
                            style: TextStyle(
                              color: const Color(0xFF7C7C7C), 
                              fontSize: 14 * scale, 
                              fontFamily: 'Poppins'
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15 * scale),
                keranjangBadge,
              ],
            ),
          ),
        ],
      ),
    );
  }
}