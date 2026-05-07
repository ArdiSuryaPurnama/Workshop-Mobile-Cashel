import 'package:flutter/material.dart';
import '../../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                _statusBadge(order.status, order.statusColor),
              ],
            ),
            const Divider(height: 24),
            _infoRow("Pengguna", order.nama),
            
            // --- BAGIAN LOOPING PRODUK ---
            // Kita petakan (map) setiap item di dalam list ke widget _infoRow
            ...order.items.map((item) {
              return _infoRow(
                item.namaProduk, 
                "${item.varian} (x${item.jumlah})"
              );
            }).toList(),
            // -----------------------------

            _infoRow("Alamat", order.alamat),
            _infoRow("Tanggal", order.tanggal),
            
            // Opsional: Tambahin Total Harga biar admin tahu berapa duit
            const Divider(height: 20),
            _infoRow("Total Pembayaran", "Rp ${order.totalHarga + order.ongkir}"),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sizedbox biar label 'Produk' atau 'Pengguna' lebarnya konsisten
          SizedBox(
            width: 80, 
            child: Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13))
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right, 
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)
            ),
          ),
        ],
      ),
    );
  }
}