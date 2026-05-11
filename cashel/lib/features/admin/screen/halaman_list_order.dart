<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../../../data/models/order_model.dart';
import '../../../data/service/order_service.dart';
import '../../admin/widgets/list_order_card.dart';
import 'halaman_informasi_pengguna.dart';

class HalamanListOrder extends StatefulWidget {
  const HalamanListOrder({super.key});

  @override
  State<HalamanListOrder> createState() => _HalamanListOrderState();
}

class _HalamanListOrderState extends State<HalamanListOrder> {
  // Inisialisasi data mock dari service
  late List<OrderModel> orders;

  @override
  void initState() {
    super.initState();
    orders = OrderService.getAllOrders();
  }

  // Fungsi untuk update status di list utama agar UI berubah
  void _updateStatus(String id, String newStatus, Color newColor) {
    setState(() {
      int index = orders.indexWhere((o) => o.id == id);
      if (index != -1) {
        orders[index].status = newStatus;
        orders[index].statusColor = newColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "List Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
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
            const SizedBox(height: 20),
            // Daftar Pesanan
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final data = orders[index];
                  return OrderCard(
                    order: data,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanInformasiPengguna(
                            order: data,
                            // Kirim callback ke halaman detail
                            onStatusChanged: (newStatus, newColor) {
                              _updateStatus(data.id, newStatus, newColor);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
=======
import 'package:flutter/material.dart';
import '../../../data/models/order_model.dart';
import '../../../data/service/order_service.dart';
import '../../admin/widgets/list_order_card.dart';
import 'halaman_informasi_pengguna.dart';

class HalamanListOrder extends StatefulWidget {
  const HalamanListOrder({super.key});

  @override
  State<HalamanListOrder> createState() => _HalamanListOrderState();
}

class _HalamanListOrderState extends State<HalamanListOrder> {
  // Inisialisasi data mock dari service
  late List<OrderModel> orders;

  @override
  void initState() {
    super.initState();
    orders = OrderService.getAllOrders();
  }

  // Fungsi untuk update status di list utama agar UI berubah
  void _updateStatus(String id, String newStatus, Color newColor) {
    setState(() {
      int index = orders.indexWhere((o) => o.id == id);
      if (index != -1) {
        orders[index].status = newStatus;
        orders[index].statusColor = newColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "List Order",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
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
            const SizedBox(height: 20),
            // Daftar Pesanan
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final data = orders[index];
                  return OrderCard(
                    order: data,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanInformasiPengguna(
                            order: data,
                            // Kirim callback ke halaman detail
                            onStatusChanged: (newStatus, newColor) {
                              _updateStatus(data.id, newStatus, newColor);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
>>>>>>> d0eec547873d7312bd5fbce0f0ccb497ee6769d6
}