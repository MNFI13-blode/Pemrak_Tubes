import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class KeranjangPage extends StatefulWidget {
  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<dynamic> keranjang = [];
  Map<int, bool> selectedItems = {};
  bool isLoading = false;
  int? idPembeli; // Menyimpan id_pembeli

  @override
  void initState() {
    super.initState();
    fetchKeranjang();
    _getUserId(); // Mengambil id_pembeli saat halaman dimuat
  }

// Fungsi untuk mengambil id_pembeli dari SharedPreferences
  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');

    if (userData != null) {
      final data = jsonDecode(userData);
      setState(() {
        idPembeli = data['id_pembeli']; // Menyimpan id_pembeli
      });
      fetchKeranjang(); // Memanggil fetchKeranjang setelah id_pembeli diambil
    }
  }

  // Fungsi untuk mengambil data keranjang berdasarkan id_pembeli
  Future<void> fetchKeranjang() async {
    if (idPembeli == null) return; // Pastikan id_pembeli sudah tersedia

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'http://localhost:3000/keranjang/$idPembeli'); // Ganti dengan id_pembeli dinamis
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Keranjang data: $data'); // Debugging log
      setState(() {
        keranjang = data['data'];
        for (var item in keranjang) {
          selectedItems[item['id_barang']] = false; // Initialize checkbox state
        }
        isLoading = false;
      });
    } else {
      print(
          'Failed to load keranjang: ${response.statusCode} - ${response.body}');
      setState(() {
        keranjang = [];
        isLoading = false;
      });
    }
  }

  // Fungsi untuk memproses pembayaran
  Future<void> prosesPembayaran() async {
    final selectedBarang = keranjang
        .where((item) => selectedItems[item['id_barang']] == true)
        .toList();

    if (selectedBarang.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pilih barang yang ingin dibeli!')),
      );
      return;
    }

    print('Selected Barang: $selectedBarang'); // Debugging log

    final url = Uri.parse('http://localhost:3000/pembayaran');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'idPembeli': idPembeli, // Menggunakan idPembeli yang dinamis
        'idPenjual': 1, // Ganti dengan ID penjual
        'barang': selectedBarang
            .map((item) => {
                  'idBarang': item['id_barang'], // Ambil id_barang
                  'jumlah': item['jumlah_barang'], // Ambil jumlah_barang
                })
            .toList(),
        'metodePembayaran': 'Saldo',
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debugging log

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembayaran berhasil!')),
      );
      fetchKeranjang(); // Refresh keranjang
    } else {
      print('Failed to process payment: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembayaran gagal!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            Text('Keranjang Belanja'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchKeranjang,
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : keranjang.isEmpty
              ? Center(
                  child: Text(
                    'Keranjang kosong, ayo mulai belanja',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: keranjang.length,
                  itemBuilder: (context, index) {
                    final item = keranjang[index];
                    final barang = item['Barang']; // Detail barang dari JSON
                    return Card(
                      child: Row(
                        children: [
                          barang['foto'] != null
                              ? Image.network(
                                  'http://localhost:3000/uploads/${barang['foto']}',
                                  width: 100,
                                  height: 100,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image_not_supported);
                                  },
                                )
                              : Icon(Icons.image_not_supported),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(barang['nama_barang'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Harga: Rp${barang['harga']}'),
                                Text(
                                    'Jumlah: ${item['jumlah_barang']}'), // Jumlah barang dalam keranjang
                              ],
                            ),
                          ),
                          Checkbox(
                            value: selectedItems[item['id_barang']],
                            onChanged: (value) {
                              setState(() {
                                selectedItems[item['id_barang']] = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: prosesPembayaran,
          child: Text('Bayar'),
        ),
      ),
    );
  }
}
