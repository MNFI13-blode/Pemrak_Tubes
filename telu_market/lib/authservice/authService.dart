import 'dart:convert';
import 'package:http/http.dart' as http;

class Authservice {
  final String apiUrl = "http://localhost:3000/api";

//Fungsi Untuk Register pembeli

  Future<Map<String, dynamic>> registerPembeli(String username, String email, String alamat, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pembeli/register'),
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'alamat': alamat,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return json.decode(response.body); // sukses register
    } else {
      return {'status': 'error', 'message': 'Gagal mendaftar'};
    }
  }

  //Fungsi untuk Login pembeli

  Future<Map<String, dynamic>> loginPembeli(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pembeli/register'),
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // Berhasil login, berisi token
    } else {
      return {'status': 'error', 'message': 'Email atau password salah'};
    }
  }
}
