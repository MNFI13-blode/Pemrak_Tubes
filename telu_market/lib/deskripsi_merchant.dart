import 'package:flutter/material.dart';

class DeskripsiMerchant extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deskripsi Merchant Store'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'gambar merchant store',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Toko Sukabirus'),
                  Text(
                    'Toko ini menjual produk alat tulis dengan mutu terbaik dan harga terjangkau. '
                    'Alat Tulis yang dijual:'
                    'Pensil Joyko, '
                    'Pensil Kenko, '
                    'Pulpen Joyko, '
                    'Pulpen Kenko, '
                  ),
                  SizedBox(height: 8),

                  Text('Toko Sukapura'),
                  Text(
                    'Toko ini menjual aksesoris laptop untuk mahasiswa dengan harga terjangkau. '
                    'Aksesoris laptop yang dijual: '
                    'Kipas Laptop, '
                    'Modem, '
                    'Kabel Jaringan, '
                    'Kabel HDMI, '
                  ),
                  SizedBox(height: 8),

                  Text('Toko Global'),
                  Text(
                    'Toko ini menjual buku-buku dengan harga terjangkau. '
                    'Buku yang dijual: '
                    'Buku Big Boss, '
                    'Buku Joyko, '
                    'Buku Kenko, '
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}