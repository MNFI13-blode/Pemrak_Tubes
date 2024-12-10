import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cart_page.dart';

List<Map<String, dynamic>> entries = [
  {"namaItem": "Sayur", "warna": Colors.green},
  {"namaItem": "Buah", "warna": Colors.red},
  {"namaItem": "Baju", "warna": Colors.blue}
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  // Fungsi untuk berpindah halaman
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search in thousands of products',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Merchant Store',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ItemCard(
                    title: 'HQ Mechanic Pencil 2B',
                    originalPrice: 'Rp. 18.000',
                    description:
                        'Pensil memiliki ketebalan yang pas untuk menulis serta menggambar',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('HQ Mechanic Pencil 2B clicked!')),
                      );
                    },
                  ),
                  ItemCard(
                    title: 'Toko Sukapura',
                    originalPrice: '',
                    description:
                        'Toko ini menjual aksesoris laptop untuk mahasiswa dengan harga terjangkau',
                  ),
                  ItemCard(
                    title: 'Toko Global',
                    originalPrice: '',
                    description:
                        'Toko ini menjual buku-buku dengan harga terjangkau',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Item Card',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ItemCard(
                    title: 'HQ Mechanic Pencil 2B',
                    originalPrice: 'Rp. 18.000',
                    description:
                        'Pensil memiliki ketebalan yang pas untuk menulis serta menggambar',
                  ),
                ],
              ),
            ),
          ),
          Center(child: Text("News Page")),
          Center(child: Text("Order Page")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_bag),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.red,
                    child: Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    "https://via.placeholder.com/150"),
              ),
            ),
            label: 'Profile', // Label for the new icon
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()),
          );
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String originalPrice;
  final String? description;
  final VoidCallback? onTap; // Callback untuk aksi ketika ditekan

  ItemCard({
    required this.title,
    required this.originalPrice,
    this.description,
    this.onTap, // Tambahkan parameter onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tangkap aksi ketika widget ditekan
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  originalPrice,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            if (description != null)
              Text(
                description!,
                style: TextStyle(color: Colors.red[800], fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
