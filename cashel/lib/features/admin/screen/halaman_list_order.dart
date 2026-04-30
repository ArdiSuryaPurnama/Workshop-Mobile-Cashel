import 'package:cashel_v2/features/admin/widgets/list_order_card.dart';
import 'package:flutter/material.dart';
import 'package:cashel_v2/features/admin/widgets/custom_bottom.dart';
import 'package:cashel_v2/features/admin/screen/profil_admin_screen.dart'; // Sesuaikan path ini


class HalamanListOrder extends StatefulWidget {
  const HalamanListOrder({super.key});

  @override
  State<HalamanListOrder> createState() => _HalamanListOrderState();
}

class _HalamanListOrderState extends State<HalamanListOrder> {
  // Index 2 untuk posisi 'List Order'
  int _selectedIndex = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
        title: const Text(
          "List Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar & Filter Icon
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.tune, color: Colors.blueGrey),
              ],
            ),
            const SizedBox(height: 20),


            // Daftar Pesanan dalam Expanded agar bisa scroll
            Expanded(
              child: ListView(
                children: [
                  OrderCard(
                    id: "#BC9809",
                    status: "In Progress",
                    nama: "Budi Setiawan",
                    produk: "Bolpoin",
                    jumlah: "3",
                    alamat: "Patihan Loceret",
                    tanggal: "Baru saja",
                    statusColor: Colors.pinkAccent,
                  ),
                  OrderCard(
                    id: "#BC9810",
                    status: "In Delivery",
                    nama: "Bayu Kusuma",
                    produk: "Penghapus",
                    jumlah: "10",
                    alamat: "Kramat Nganjuk",
                    tanggal: "14 menit lalu",
                    statusColor: Colors.orange,
                  ),
                  OrderCard(
                    id: "#BC9813",
                    status: "In Delivery",
                    nama: "Zaki",
                    produk: "Peghapus",
                    jumlah: "6",
                    alamat: "Nganjuk",
                    tanggal: "20 menit lalu",
                    statusColor: Colors.orange,
                  ),
                  OrderCard(
                    id: "#BC9811",
                    status: "Complete",
                    nama: "Budi Setiawan",
                    produk: "Spidol",
                    jumlah: "6",
                    alamat: "Jatiarjo Loceret",
                    tanggal: "2 hari lalu",
                    statusColor: Colors.green,
                  ),
                    OrderCard(
                    id: "#BC9812",
                    status: "Complete",
                    nama: "Zaki",
                    produk: "Staples",
                    jumlah: "1",
                    alamat: "Pace",
                    tanggal: "2 hari lalu",
                    statusColor: Colors.green,
                  ),
                                    OrderCard(
                    id: "#BC9812",
                    status: "Complete",
                    nama: "Budi",
                    produk: "Kertas HVS",
                    jumlah: "5",
                    alamat: "Jati",
                    tanggal: "3 hari lalu",
                    statusColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Memanggil CustomBottomNav dari folder widget
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Tambahkan logika navigasi halaman di sini
          
        if (index == 4) { // Indeks 4 adalah menu 'Akun'
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilAdminScreen()),
      );
        }
        },
      ),
    );
  }
}
