import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:telu_market/receipt.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> categories = ["All", "Pensil", "Pena"];
  String selectedCategory = "All"; // Gunakan string untuk kategori yang dipilih
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: null,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              )
            : const Text(
                "Welcome, User",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching; // Toggle search bar visibility
                if (!_isSearching) {
                  _searchController.clear(); // Clear input when search is deactivated
                }
              });
            },
            icon: Icon(
              _isSearching ? Iconsax.close_circle : Iconsax.search_normal, // Toggle between search and close icon
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              // Ganti bagian ListView biasa dengan ListView.builder
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              categories[index]; // Update kategori yang dipilih
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: selectedCategory == categories[index]
                              ? Colors.orange // Warna saat kategori dipilih
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: selectedCategory == categories[index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Menjaga jarak antar card
                children: [
                  Expanded(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: makeItem(
                        image: "lib/assets/login.png",
                        context: context,
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Memberikan jarak antar card
                  Expanded(
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: makeItem(
                        image: "lib/assets/login.png",
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
            currentIndex = index; // Update indeks saat item di-tap
          });

          // Aksi berdasarkan indeks
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              break;
            case 1:
              print("Navigasi ke Order");
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReceiptScreen()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
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

  Widget makeItem({required String image, BuildContext? context}) {
    return GestureDetector(
      child: Container(
        width: 240,
        height: 295,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8), // Reduced space between image and name
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                "Sneakers",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 3), // Reduced space between name and stock
            FadeInUp(
              duration: const Duration(milliseconds: 1100),
              child: const Text(
                "Stock: 10",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 3), // Reduced space between stock and price
            FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: const Text(
                "100\$",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Tambahkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}