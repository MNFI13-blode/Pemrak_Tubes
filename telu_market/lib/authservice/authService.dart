import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/pembeli/login'),
      body: json.encode({
        'username': username,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
       final token = data['token'];
       final pembeliData = data['dataPembeli'];
       
       await saveToken(token);
        await saveUserData(pembeliData);
      print('Login berhasil, token dan data pembeli disimpan!');
      return json.decode(response.body); 
      // Berhasil login, berisi token
    } else {
      return {'status': 'error', 'message': 'Email atau password salah'};
    }

    
  }
  Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  print('Token disimpan: $token');
}

Future<void> saveUserData(Map<String, dynamic> data) async {
  final prefs = await SharedPreferences.getInstance();
  String jsonData = jsonEncode(data); // Mengonversi Map ke JSON string
  await prefs.setString('userData', jsonData);
  print('Data Pembeli disimpan: $jsonData');
}

Future<Map<String, dynamic>> updateProfile(int id_pembeli, String username, String alamat, String email)async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if(token == null){
    throw Exception('User not authenticated');
  }

  final url = Uri.parse('$apiUrl/pembeli/update-profile');
  final requestBody = {
    'id_pembeli' :id_pembeli,
    'username' : username,
    'alamat' : alamat,
    'email' : email,
  };

  final response = await http.put(url,
  headers: {
    'Content-Type': 'application/json',},
    body:  jsonEncode(requestBody),
  );

  if(response.statusCode == 200){
    final updatedData = jsonDecode(response.body);

      await prefs.setString('userData', jsonEncode(updatedData['data']));
       print('Profile updated successfully');
       return json.decode(response.body); 
       
  }else{
       
       return {'status': 'error', 'message': 'Gagal update profile'};
  }
}
}
