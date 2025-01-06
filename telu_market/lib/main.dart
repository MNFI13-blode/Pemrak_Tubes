import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'login.dart';
import 'receipt.dart';
import 'authservice/notifi_service.dart';
>>>>>>> Stashed changes

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< Updated upstream
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Map<String, dynamic>> entries = [
  {
    "namaItem": "HQ Mechanic Pencil 2B",
    "harga": "12.000",
    "warna": Colors.green
  },
  {"namaItem": "Fabercastel color", "harga": "12.000", "warna": Colors.red},
  {
    "namaItem": "Air Minum Kemasan Sachet",
    "harga": "12.000",
    "warna": Colors.blue
  }
];

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0; // Menyimpan indeks halaman aktif
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
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("Buah Batu", style: TextStyle(color: Colors.red)),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
          ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        title: 'Kos 1',
                        subtitle: 'Bojong santos\njl. wibu',
                      ),
                      CategoryCard(
                        title: 'Kos Aril',
                        subtitle: 'Ciganitri\njl. cosplay',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Explore by Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryIcon(
                        title: 'Menulis',
                        icon: Icons.edit,
                        color: Colors.pink,
                      ),
                      CategoryIcon(
                        title: 'Menggambar',
                        icon: Icons.brush,
                        color: Colors.yellow,
                      ),
                      CategoryIcon(
                        title: 'Alat gambar',
                        icon: Icons.palette,
                        color: Colors.purple,
                      ),
                      CategoryIcon(
                        title: 'Merchant',
                        icon: Icons.store,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Deals of the Day',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Call DiscountCard widget here
                  DiscountCard(),
                  SizedBox(height: 10),
                  // Another Deal Card example
                  DealCard(
                    title: 'HQ Mechanic Pencil 2B',
                    originalPrice: 'Rp. 18.000',
                    discountedPrice: 'Rp. 12.000',
                  ),
                ],
              ),
            ),
          ),
          Center(child: Text("News Page")),
          Center(child: Text("Favorites Page")),
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
            icon: Icon(Icons.store),
            label: 'Grocery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
        child: Icon(Icons.shopping_cart), //di sini kerjaan Ariel
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Saya"),
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
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: avatarColor,
                        radius: 24,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entries[index]['namaItem']}',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            '${entries[index]['harga']}',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;

  CategoryCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Sesuaikan lebar sesuai kebutuhan
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.map, color: Colors.grey.shade700),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  CategoryIcon({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }
}

class DealCard extends StatelessWidget {
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final String? description;

  DealCard({
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 10),
              Text(
                discountedPrice,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          if (description != null)
            Text(
              description!,
              style: TextStyle(color: Colors.red[800], fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mega',
            style: TextStyle(
              color: Colors.red.shade700,
              fontSize: 14,
            ),
          ),
          Text(
            'Discon',
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Rp 17.000',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Rp 32.000',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '* Available until 24 July 2023',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Grocery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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
        ],
      ),
    );
  }
}

class Merchant {
  final String namaMerchant;
  final Icon icon;

  Merchant({required this.icon, required this.namaMerchant});
}

class MerchantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Merchant> merchant = [
      Merchant(icon: const Icon(Icons.store), namaMerchant: "Toko Serba Ada"),
      Merchant(icon: const Icon(Icons.store), namaMerchant: "Toko Global"),
      Merchant(icon: const Icon(Icons.store), namaMerchant: "Toko Sukabirus"),
      Merchant(icon: const Icon(Icons.store), namaMerchant: "Toko Sukapura")
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Merchant",
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: ListView.builder(
        itemCount: merchant.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(merchant[index].namaMerchant),
            leading: Icon(merchant[index].icon as IconData?),
          );
        },
      ),
=======
      title: 'Tel-U Market',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ReceiptScreen(),
>>>>>>> Stashed changes
    );
  }
}
