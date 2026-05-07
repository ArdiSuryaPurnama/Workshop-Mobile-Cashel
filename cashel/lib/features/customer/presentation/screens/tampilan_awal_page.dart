import 'package:flutter/material.dart';
import '../widgets/produk_card.dart';
import '../widgets/grosir_card.dart';
import '../data_produk.dart'; // Import file data master tunggal
import 'halaman_grosir.dart';
import 'semua_produk.dart';
import 'akun.dart'; 

class TampilanAwalPage extends StatefulWidget {
  const TampilanAwalPage({super.key});

  @override
  State<TampilanAwalPage> createState() => _TampilanAwalPageState();
}

class _TampilanAwalPageState extends State<TampilanAwalPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Variabel untuk menampung hasil filter pencarian
  List<Map<String, String>> _produkTerfilter = [];

  @override
  void initState() {
    super.initState();
    // Mengambil data awal dari daftarProdukMaster di data_produk.dart
    _produkTerfilter = daftarProdukMaster;
  }

  void _jalankanPencarian(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _produkTerfilter = daftarProdukMaster;
      } else {
        _produkTerfilter = daftarProdukMaster
            .where((produk) => produk['title']!.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildMainContent(),
      const Scaffold(body: Center(child: Text("Halaman History", style: TextStyle(fontFamily: 'Poppins')))),
      const Scaffold(body: Center(child: Text("Halaman Notifikasi", style: TextStyle(fontFamily: 'Poppins')))),
      const AkunPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0862FD),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/beranda.png', width: 24, color: _selectedIndex == 0 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/history.png', width: 24, color: _selectedIndex == 1 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/notifikasi.png', width: 24, color: _selectedIndex == 2 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/akun.png', width: 24, color: _selectedIndex == 3 ? const Color(0xFF0862FD) : Colors.grey),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scale = constraints.maxWidth / 414;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20 * scale, 50 * scale, 20 * scale, 20 * scale),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0862FD),
                image: DecorationImage(
                  image: AssetImage('assets/images/top_bar.png'),
                  fit: BoxFit.cover,
                  opacity: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45 * scale,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12 * scale)),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _jalankanPencarian,
                        decoration: InputDecoration(
                          hintText: "Cari produk",
                          hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Poppins', fontSize: 16 * scale),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12 * scale),
                            child: Image.asset('assets/images/search.png', width: 20 * scale),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11 * scale),
                        ),
                        style: TextStyle(fontSize: 16 * scale, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  SizedBox(width: 15 * scale),
                  Image.asset('assets/images/cart.png', width: 25 * scale, color: Colors.white),
                  SizedBox(width: 15 * scale),
                  Image.asset('assets/images/message.png', width: 25 * scale, color: Colors.white),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_searchController.text.isEmpty) ...[
                      Padding(
                        padding: EdgeInsets.all(20 * scale),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12 * scale),
                          child: Image.asset('assets/images/hero_banner.png', fit: BoxFit.contain),
                        ),
                      ),
                      _buildSectionTitle(context, "Grosir", scale),
                      SizedBox(
                        height: 100 * scale,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 20 * scale),
                          children: [
                            GrosirCard(title: "Kertas HVS", imagePath: "assets/images/kertas_hvs.png", scale: scale),
                            GrosirCard(title: "Buku Tulis", imagePath: "assets/images/buku_tulis.png", scale: scale),
                            GrosirCard(title: "Pensil", imagePath: "assets/images/pensil.png", scale: scale),
                            GrosirCard(title: "Map", imagePath: "assets/images/map_small.png", scale: scale),
                          ],
                        ),
                      ),
                    ],
                    _buildSectionTitle(context, _searchController.text.isEmpty ? "Produk" : "Hasil Pencarian", scale),
                    _produkTerfilter.isEmpty
                        ? Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 50 * scale), child: const Text("Produk tidak ditemukan")))
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _produkTerfilter.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15 * scale,
                                crossAxisSpacing: 15 * scale,
                                childAspectRatio: 173 / 245,
                              ),
                              itemBuilder: (context, index) {
                                return ProdukCard(
                                  title: _produkTerfilter[index]['title']!,
                                  price: _produkTerfilter[index]['price']!,
                                  imagePath: _produkTerfilter[index]['imagePath']!,
                                  stok: _produkTerfilter[index]['stok']!,
                                  description: _produkTerfilter[index]['description']!,
                                  scale: scale,
                                );
                              },
                            ),
                          ),
                    SizedBox(height: 30 * scale),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, double scale) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 25 * scale, 20 * scale, 15 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 22 * scale, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
          if (_searchController.text.isEmpty)
            GestureDetector(
              onTap: () {
                if (title == "Grosir") Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanGrosir()));
                else Navigator.push(context, MaterialPageRoute(builder: (context) => const SemuaProdukPage()));
              },
              child: Text("Lihat semua", style: TextStyle(color: const Color(0xFF1666BA), fontSize: 14 * scale, fontFamily: 'Poppins')),
            ),
        ],
      ),
    );
  }
}