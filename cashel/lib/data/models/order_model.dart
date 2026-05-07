import 'package:flutter/material.dart';
import 'order_item_model.dart';

class OrderModel{
  final String id;
  final String nama;
  final String alamat;
  final List<OrderItemModel> items;
  
  final String tanggal;
  String status;
  final String email;
  final String tanggalRegristasi;
 
  final String metodePembayaran;
  
  final int ongkir;
  Color statusColor;

  OrderModel({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.items,
    
    required this.tanggal,
    required this.status,
    required this.email,
    required this.tanggalRegristasi,
    
    required this.metodePembayaran,
    required this.ongkir,
    required this.statusColor
  });
  // Pastikan baris ini sudah benar
int get totalHarga => items.fold(0, (sum, item) {
  // Kita pastikan item diperlakukan sebagai OrderItemModel
  return sum + (item.harga * item.jumlah);
});


}