import 'package:flutter/material.dart';

class DeskripsiMerchant extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deskripsi Merchant Store'),
      ),
      body: Center(
        child: Column(
          children: [
              Text('Toko Sukabirus'),
              Text('Toko ini menjual produk alat tulis dengan mutu terbaik dan harga terjangkau'),
        
              Text('Toko Sukapura'),
              Text('Toko ini menjual aksesoris laptop untuk mahasiswa dengan harga terjangkau'),
        
              Text('Toko Global'),
              Text('Toko ini menjual buku-buku dengan harga terjangkau'),
          ],
        ),
      ),
    );
  }
}