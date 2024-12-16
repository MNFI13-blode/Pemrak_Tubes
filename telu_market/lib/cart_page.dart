import 'package:flutter/material.dart';

// Data dummy untuk keranjang
List<Map<String, dynamic>> entries = [
  {"namaItem": "Sayur", "warna": Colors.green},
  {"namaItem": "Buah", "warna": Colors.red},
  {"namaItem": "Baju", "warna": Colors.blue}
];

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            Color avatarColor = entries[index]['warna'];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: avatarColor,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entries[index]['namaItem']}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
