import 'dart:convert';
import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/produk_card.dart';
import '../widgets/grosir_card.dart';
import '../widgets/tampilan_awal_widgets.dart'; 
import 'halaman_grosir.dart';
import 'semua_produk.dart';
import 'halaman_pencarian.dart';
import 'akun.dart';

// variabel global
final ValueNotifier<int> globalKeranjang = ValueNotifier<int>(0);

class TampilanAwalPage extends StatefulWidget {
  const TampilanAwalPage({super.key});

  @override
  State<TampilanAwalPage> createState() => _TampilanAwalPageState();
}

class _TampilanAwalPageState extends State<TampilanAwalPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isScrolled = false;

  Future<List<dynamic>>? _futureGrosir;
  Future<List<dynamic>>? _futureProduk;

  final List<String> _bannerImages = [
    "assets/images/hero_banner.png",
  ];

  @override
  void initState() {
    super.initState();
    _muatUlangData();
    
    
    _scrollController.addListener(() {
      if (_scrollController.offset > 10 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 10 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });

    if (_bannerImages.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_currentPage < _bannerImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage, 
            duration: const Duration(milliseconds: 350), 
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _muatUlangData() {
    _futureGrosir = ambilDataGrosir();
    _futureProduk = ambilProduk();
  }

  void _tambahKeKeranjang() {
    globalKeranjang.value++; 
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil ditambahkan", style: TextStyle(fontFamily: 'Poppins')),
        duration: Duration(seconds: 1),
        backgroundColor: Color(0xFF0862FD),
      ),
    );
  }

  Future<List<dynamic>> ambilDataGrosir() async {
    const String url = 'http://localhost/api_cashel/product/get_product.php?kategori=grosir';
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200 ? json.decode(response.body) : [];
    } catch (e) { return []; }
  }

  Future<List<dynamic>> ambilProduk() async {
    const String url = 'http://localhost/api_cashel/product/get_product.php?kategori=satuan';
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200 ? json.decode(response.body) : [];
    } catch (e) { return []; }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scale = constraints.maxWidth / 414;
        
        return TampilanAwalWidget(
          selectedIndex: _selectedIndex,
          scale: scale,
          isScrolled: _isScrolled,
          onItemTapped: (index) => setState(() => _selectedIndex = index),
          onSearchTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanPencarian())),
          keranjangBadge: _buildKeranjangBadge(),
          bodyContent: _buildBody(scale),
        );
      },
    );
  }

  Widget _buildKeranjangBadge() {
    return ValueListenableBuilder<int>(
      valueListenable: globalKeranjang,
      builder: (context, value, child) {
        return Stack(
          children: [
            const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
            if (value > 0)
              Positioned(
                right: 0, top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text('$value', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBody(double scale) {
    if (_selectedIndex == 3) return const AkunPage();

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(top: 10 * scale),
      children: [
        if (_selectedIndex == 0) ...[
          _buildBanner(scale),
          _buildSectionTitle(context, "Grosir", scale),
          _buildGrosirList(scale),
          _buildSectionTitle(context, "Produk", scale),
          _buildProductGrid(scale),
        ] else if (_selectedIndex == 1) ...[
          const Center(child: Padding(padding: EdgeInsets.all(100), child: Text("Halaman Riwayat", style: TextStyle(fontFamily: 'Poppins')))),
        ] else if (_selectedIndex == 2) ...[
          const Center(child: Padding(padding: EdgeInsets.all(100), child: Text("Halaman Notifikasi", style: TextStyle(fontFamily: 'Poppins')))),
        ]
      ],
    );
  }

  Widget _buildBanner(double scale) {
    return Container(
      height: 115 * scale,
      margin: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _bannerImages.length,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(15 * scale),
          child: Image.asset(_bannerImages[index], fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildGrosirList(double scale) {
    return SizedBox(
      height: 100 * scale,
      child: FutureBuilder<List<dynamic>>(
        future: _futureGrosir,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return GrosirCard(
                title: item['nama_produk'] ?? "Grosir", 
                imagePath: "assets/images/${item['gambar'] ?? 'placeholder.png'}", 
                scale: scale
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(double scale) {
    return FutureBuilder<List<dynamic>>(
      future: _futureProduk,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              mainAxisSpacing: 15 * scale, 
              crossAxisSpacing: 15 * scale, 
              childAspectRatio: 0.7
            ),
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return ProdukCard(
                title: item['nama_produk'] ?? "Produk",
                price: "Rp ${item['harga'] ?? '0'}",
                imagePath: "assets/images/${item['gambar'] ?? 'placeholder.png'}",
                stok: (item['stok'] ?? 0).toString(),
                description: item['deskripsi'] ?? "",
                scale: scale,
                onAddTap: _tambahKeKeranjang,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, double scale) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20 * scale, 20 * scale, 20 * scale, 10 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18 * scale, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
          TextButton(
            onPressed: () {
              if (title == "Grosir") Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanGrosir()));
              else if (title == "Produk") Navigator.push(context, MaterialPageRoute(builder: (context) => const SemuaProdukPage()));
            }, 
            child: const Text("Lihat semua", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF0862FD))),
          ),
        ],
      ),
    );
  }
}