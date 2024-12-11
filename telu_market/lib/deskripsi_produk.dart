import 'package:flutter/material.dart';

class DeskripsiProduk extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deskripsi Produk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pensil mekanik.jpeg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Toko Sukapura',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'HQ Pencil Mechanic 2B',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Pensil dengan pena yang nyaman dan mudah digunakan serta harga terjangkau, cocok untuk menulis dan menggambar',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 16),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Produk ditambahkan ke keranjang')),
                        );
                      }, 
                      icon: Icon(Icons.add_shopping_cart_rounded),
                      label: Text('Tambah ke keranjang')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}