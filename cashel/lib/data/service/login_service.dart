import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class LoginService {
  // Ganti localhost ke IP jika ingin tes di HP fisik
  final String baseUrl = "http://localhost/api_cashel/auth/login.php";

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // Mengubah JSON dari PHP ke objek UserModel
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return UserModel(
          status: "error",
          message: "Server Error: ${response.statusCode}"
        );
      }
    } catch (e) {
      return UserModel(
        status: "error", 
        message: "Koneksi login gagal: $e"
      );
    }
  }
}