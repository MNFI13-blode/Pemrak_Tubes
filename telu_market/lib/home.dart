import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:http/http.dart' as http;
import 'profile_page.dart';
import 'cart_page.dart';
import 'receipt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> categories = ["All"];
  String selectedCategory = "All";
  int currentIndex = 0;
  List<dynamic> items = [];
  List<dynamic> filteredItems = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/barang'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          items = data;
          filteredItems = data;
          Set<String> uniqueCategories = {"All"};
          for (var item in data) {
            if (item['jenis_barang'] != null) {
              uniqueCategories.add(item['jenis_barang']);
            }
          }
          categories = uniqueCategories.toList();
        });
      } else {
        print("Failed to load items: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching items: $error");
    }
  }

  Future<void> saveUserData(String idPembeli) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_pembeli', idPembeli);
  }

  Future<void> addToCart(String idBarang, String jumlahBarang) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idPembeli = prefs.getString('id_pembeli');
      if (idPembeli == null) {
        print("User not logged in");
        return;
      }

      final response = await http.post(
        Uri.parse('http://localhost:3000/keranjang/tambah-barang'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_pembeli": idPembeli,
          "id_barang": idBarang,
          "jumlah_barang": int.parse(jumlahBarang),
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['message'].contains('ditambahkan') ||
            responseData['message'].contains('diperbarui')) {
          print("Barang berhasil ditambahkan atau diperbarui di keranjang");
          await fetchItems(); // Refresh data stok barang
        } else {
          print("Respon tidak terduga: ${responseData['message']}");
        }
      } else {
        print("Gagal menambahkan ke keranjang: ${responseData['message']}");
      }
    } catch (error) {
      print("Error adding to cart: $error");
    }
  }

  void searchItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) =>
                item['nama_barang']
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item['jenis_barang']
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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
                onChanged: searchItems,
              )
            : const Text(
                "Welcome, User",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  searchItems("");
                }
              });
            },
            icon: Icon(
              _isSearching ? Iconsax.close_circle : Iconsax.search_normal,
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
            children: [
              Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = categories[index];
                          if (selectedCategory == "All") {
                            filteredItems = items;
                          } else {
                            filteredItems = items
                                .where((item) =>
                                    item['jenis_barang'] == selectedCategory)
                                .toList();
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: selectedCategory == categories[index]
                              ? Colors.orange
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
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: makeItem(
                      image: filteredItems[index]['foto'],
                      name: filteredItems[index]['nama_barang'],
                      price: filteredItems[index]['harga'].toString(),
                      stock: filteredItems[index]['jumlah_barang'].toString(),
                      index: index,
                    ),
                  );
                },
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
            currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KeranjangPage()));
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

  Widget makeItem({
    required String? image,
    required String name,
    required String price,
    required String stock,
    BuildContext? context,
    required int index,
  }) {
    return GestureDetector(
      child: Container(
        width: 240,
        height: 255,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.lightGreenAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.grey[200],
                child: image != null && image.isNotEmpty
                    ? Image.network(
                        image,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 60,
                              color: Colors.grey,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 3),
            FadeInUp(
              duration: const Duration(milliseconds: 1100),
              child: Text(
                "Stock: $stock",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 3),
            FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: ElevatedButton(
                  onPressed: () {
                    addToCart(
                      filteredItems[index]['id_barang'].toString(),
                      '1',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Icon(
                    Iconsax.shopping_cart,
                    color: Colors.white,
                    size: 20,
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
