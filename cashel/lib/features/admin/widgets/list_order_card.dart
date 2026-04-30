import 'package:flutter/material.dart';
import 'package:cashel_v2/core/constant/app_text_styles.dart';

class OrderCard extends StatelessWidget {
  final String id, status, nama, produk, jumlah, alamat, tanggal;
  final Color statusColor;

  const OrderCard({
    super.key,
    required this.id, required this.status, required this.nama,
    required this.produk, required this.jumlah, required this.alamat,
    required this.tanggal, required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
              _statusBadge(),
            ],
          ),
          const Divider(height: 24),
          _infoRow("Pengguna", nama),
          _infoRow("Produk", produk),
          _infoRow("Jumlah", jumlah),
          _infoRow("Alamat", alamat),
          _infoRow("Tanggal", tanggal),
        ],
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor),
      ),
      child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(
        label,
        style: AppTextStyles.infoPengguna.copyWith(
          color: Colors.grey[600],
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        value,
        style: AppTextStyles.infoPengguna.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
       ],
      ),
    );
  }
}

