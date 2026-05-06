import 'package:flutter/material.dart';
import '../../../data/models/order_model.dart';
import '../widgets/kelola_pesanan.dart';
import '../widgets/informasi_pengguna_card.dart'; // Sesuaikan path widget kelola pesanan kamu

class HalamanInformasiPengguna extends StatelessWidget {
  final OrderModel order;
  final Function(String newStatus, Color newColor) onStatusChanged;

  const HalamanInformasiPengguna({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Informasi Pengguna", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            const SizedBox(height: 30),

              InformasiPenggunaCard(label: "Serial", value: order.id, isBold: true),
            
            // Card Info User
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  _buildRow("Nama", order.nama),
                  const Divider(),
                  _buildRow("Email", order.email),
                  const Divider(),
                  _buildRow("Alamat", order.alamat),
                  const Divider(),
                  _buildRow("Tanggal Regristrasi", order.tanggalRegristasi)
                
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Bagian Catatan Pesanan & Tombol Kelola
            _buildCatatanPesanan(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildCatatanPesanan(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Catatan Pemesanan", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          // List Produk
          ...order.items.map((item) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.shopping_bag, color: Colors.blue),
            title: Text(item.namaProduk, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Varian: ${item.varian}\nJumlah: ${item.jumlah}"),
            trailing: Text("Rp ${item.harga * item.jumlah}"),
          )).toList(),
          const Divider(),
          Text("Total: Rp ${order.totalHarga + order.ongkir}", 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
          const SizedBox(height: 20),
          
          // TOMBOL KELOLA PESANAN
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => KelolaPesananWidget(
                    order: order,
                    onAccept: () {
                      onStatusChanged("Diproses", Colors.blue);
                      Navigator.pop(context); // Tutup BottomSheet
                      Navigator.pop(context); // Balik ke List
                    },
                    onReject: () {
                      onStatusChanged("Dibatalkan", Colors.red);
                      Navigator.pop(context); // Tutup BottomSheet
                      Navigator.pop(context); // Balik ke List
                    },
                  ),
                );
              },
              child: const Text("Kelola Pesanan", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}