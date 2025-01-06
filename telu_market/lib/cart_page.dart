import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'authservice/notifi_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KeranjangPage(),
    );
  }
}

class KeranjangPage extends StatefulWidget {
  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<dynamic> keranjang = [];
  Map<int, bool> selectedItems = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchKeranjang();
  }

  Future<void> fetchKeranjang() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('http://10.0.2.2:3000/keranjang/1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Keranjang data: $data');
      setState(() {
        keranjang = data['data'];
        for (var item in keranjang) {
          selectedItems[item['id_barang']] = false;
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

    print('Selected Barang: $selectedBarang');
    final url = Uri.parse('http://10.0.2.2:3000/pembayaran');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'idPembeli': 1,
        'idPenjual': 1,
        'barang': selectedBarang
            .map((item) => {
                  'idBarang': item['id_barang'],
                  'jumlah': item['jumlah_barang'],
                })
            .toList(),
        'metodePembayaran': 'Saldo',
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembayaran berhasil!')),
      );
      fetchKeranjang();
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
                    final barang = item['Barang'];
                    return Card(
                      child: Row(
                        children: [
                          barang['foto'] != null
                              ? Image.network(
                                  'http://10.0.2.2:3000/uploads/${barang['foto']}',
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
                                Text('Jumlah: ${item['jumlah_barang']}'),
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
          onPressed: () {
            prosesPembayaran();
            NotificationService().showNotification(title: 'Hay', body: 'No');
          },
          child: const Text('Bayar'),
        ),
      ),
    );
  }
}
