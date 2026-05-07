import 'package:flutter/material.dart';

// Import Widgets
import '../widgets/order_stats_card.dart';
import '../widgets/admin_chart.dart';

// Import Models & Services
import '../../../data/models/order_stats_model.dart';
import '../../../data/service/mock_data_order_stats.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data dari service mock
    final OrderStatsModel stats = MockOrderService.getSummary();

    // HAPUS Scaffold, ganti langsung ke SafeArea atau Container
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Halaman
            const Text(
              "Beranda",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 25),

            // Bagian Statistik Order (New & Pending)
            Row(
              children: [
                Expanded(
                  child: OrderStatsCard(
                    title: "New orders",
                    count: stats.newOrders,
                    gradientColors: const [Color(0xFF4A68FF), Color(0xFF2144FA)],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OrderStatsCard(
                    title: "Pending orders",
                    count: stats.pendingOrders,
                    gradientColors: const [Color(0xFF3DA9FF), Color(0xFF158DFF)],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Bagian Grafik Aktivitas (Income)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Activities",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  
                  // Memanggil widget admin_chart.dart
                  const SizedBox(
                    height: 250,
                    child: AdminChart(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}