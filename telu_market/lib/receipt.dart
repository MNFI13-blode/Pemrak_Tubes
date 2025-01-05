import 'package:flutter/material.dart';
import 'package:telu_market/home.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'profile_page.dart';

class ReceiptScreen extends StatefulWidget{
  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<ReceiptScreen> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt", style: TextStyle(fontSize: 18),),
      ),
      body: PageView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text("Id Pembayaran:", style: TextStyle(fontSize: 14),),
                  Text("1"),
                  SizedBox(height: 16.0),

                  Text("Status Transaksi", style: TextStyle(fontSize: 14),),
                  Text("Berhasil"),
                  SizedBox(height: 16.0),

                  Text("Saldo", style: TextStyle(fontSize: 14),),
                  Text("13000"),
                  SizedBox(height: 16.0),

                  Text("Id Barang", style: TextStyle(fontSize: 14),),
                  Text("1"),
                  SizedBox(height: 16.0),

                  Text("Jumlah Barang", style: TextStyle(fontSize: 14),),
                  Text("2"),
                  SizedBox(height: 16.0),

                  Text("Harga Satuan", style: TextStyle(fontSize: 14),),
                  Text("30000"),
                  SizedBox(height: 16.0),
                  
                  Text("Total Pembayaran", style: TextStyle(fontSize: 14),),
                  Text("6000"),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });

          switch (index) {
            case 0:
              // Menggunakan Navigator.pushReplacement untuk mengganti halaman tanpa back button
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              print("Navigasi ke Order");
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReceiptScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.receipt_2),
            label: 'Receipt',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}