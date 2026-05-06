import 'dart:convert';

class UserModel {
  final String status;
  final String message;
  final UserData? data;

  UserModel({required this.status, required this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['status'] == 'success' && json['data'] != null
          ? UserData.fromJson(json['data'])
          : null,
    );
  }
}

class UserData {
  final String idAkun;
  final String nama;
  final String role;

  UserData({required this.idAkun, required this.nama, required this.role});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      idAkun: json['id_akun'].toString(),
      nama: json['nama'] ?? '',
      role: json['role'] ?? 'customer',
    );
  }
}