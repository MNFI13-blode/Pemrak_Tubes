import 'package:flutter/material.dart';
import 'package:telu_market/deskripsi_merchant.dart';
import 'package:telu_market/deskripsi_produk.dart';
import 'profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cart_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  final List<Map<String, String>> items = [
    {'title': 'HQ Mechanic Pencil 2B', 'price': 'Rp. 18.000'},
  ];

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
                    title: 'Toko Sukabirus',
                    originalPrice: '',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeskripsiMerchant()));
                    },
                  ),
                  Divider(),
                  ItemCard(
                    title: 'Toko Sukapura',
                    originalPrice: '',
                  ),
                  Divider(),
                  ItemCard(
                    title: 'Toko Global',
                    originalPrice: '',
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item Card',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.orange),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              String? itemName;
                              String? itemPrice;

                              return AlertDialog(
                                title: Text('Add Item'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Item Name'),
                                      onChanged: (value) {
                                        itemName = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Item Price'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        itemPrice = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (itemName != null &&
                                          itemPrice != null) {
                                        setState(() {
                                          items.add({
                                            'title': itemName!,
                                            'price': itemPrice!
                                          });
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Column(
                          children: [
                            ItemCard(
                              title: item['title']!,
                              originalPrice: item['price']!,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DeskripsiProduk()));
                              },
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  // ItemCard(
                  //   title: 'HQ Mechanic Pencil 2B',
                  //   originalPrice: 'Rp. 18.000',
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => DeskripsiProduk()));
                  //   },
                  // ),
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
