import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/order_item_model.dart';

class OrderService {
  static List <OrderModel> getAllOrders() {
  return [
    OrderModel(
      id: "#BC9809",
      status: "in Progress",
      nama: "Budi Setiawan",
      email: "budisetiawan15oke@gmail.com",
     items: [
    OrderItemModel(
      namaProduk: "Bolpoin",
      varian: "Snowman Black",
      jumlah: 3,
      harga: 3000,
    ),
    OrderItemModel(
      namaProduk: "Buku",
      varian: "Sinar Dunia Isi 38",
      jumlah: 1,
      harga: 5000,
    ),
  ],
      alamat: "Jl. Gajahmada III, Karang Lo, Patihan, Kec. Loceret, Kabupaten Nganjuk, Jawa Timur 64471",
      tanggal: "Baru saja",
      tanggalRegristasi: "14 Februari 2026",
      statusColor: Colors.pinkAccent,
    
      ongkir: 1000,
      metodePembayaran: "COD",
    ),
    OrderModel(
        id: "#BC9810",
        status: "In Delivery",
        nama: "Bayu Kusuma",
        email: "bayukusuma@gmail.com",
     items: [
    OrderItemModel(
      namaProduk: "Bolpoin",
      varian: "Snowman Black",
      jumlah: 3,
      harga: 3000,
    ),
     ],
        alamat: "Kramat Nganjuk",
        tanggal: "14 menit lalu",
        tanggalRegristasi: "01 Januari 2026",
        statusColor: Colors.orange,
        
        ongkir: 2000,
        metodePembayaran: "Transfer",
      ),
    ];
  }
}
      
      
