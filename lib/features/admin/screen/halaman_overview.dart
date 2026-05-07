import 'package:flutter/material.dart';

// Import Widgets
import '../widgets/overview_stat_card.dart';
import '../widgets/admin_table.dart';
import '../widgets/admin_chart.dart'; // Import chart yang sudah kita buat

// Import Models & Services
import 'package:cashel_v2/data/models/overview_stats_model.dart';
import '../../../data/service/mock_overview_stats.dart';

class HalamanOverview extends StatelessWidget {
  const HalamanOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OverviewStatsModel> statsData = OverviewServices.getOverviewStats();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // 1. Kotak Statistik (4 Kotak Biru)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: statsData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                return OverviewStatCard(data: statsData[index]);
              },
            ),

            const SizedBox(height: 30),

            // 2. Bagian Grafik (Sesuai Gambar yang Kamu Kirim)
            

            const SizedBox(height: 30),

            // 3. Judul & Tabel Histori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Histori Pemesanan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text("Lihat Semua")),
              ],
            ),
            const SizedBox(height: 10),
            const AdminTable(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}