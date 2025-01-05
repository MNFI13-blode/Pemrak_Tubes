import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'authservice/authService.dart';
import 'home.dart';
import 'login.dart'; // Ganti dengan path halaman login Anda

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userData');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final userData = await getUserData();
    return userData;
    //return {
    //'username': 'Andy',
    //'alamat': 'Bandung',
    //'email': 'andy@example.com',
    //'id_pembeli': 12345,
  //};
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Profiles", style: TextStyle(fontSize: 14)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No profile data available'),
            );
          }

          final userData = snapshot.data!;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage('assets/photo/defaultAvatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Edit Profile",
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nama:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userData['username'] ?? '_'),
                        const Divider(),
                        const Text("Alamat:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userData['alamat'] ?? '_'),
                        const Divider(),
                        const Text("Email:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userData['email'] ?? '_'),
                        const Divider(),
                        const Text("ID:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userData['id_pembeli']?.toString() ?? '_'),
                        const Divider(),
                        const Text("Saldo :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(userData['saldo']?.toString() ?? '_'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Logout
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear(); // Menghapus semua data dari SharedPreferences

                      // Arahkan ke halaman login setelah logout
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(), // Ganti dengan halaman login Anda
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logout berhasil')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Logout", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile;

  // Fungsi untuk memilih gambar dari kamera atau galeri
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('userData');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    final userData = await getUserData();
    return userData;
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  final Authservice authservice = Authservice();

  Future<void> _saveProfile() async {
    try {
      final userData = await SharedPreferences.getInstance();
      final userId =
          jsonDecode(userData.getString('userData') ?? '')['id_pembeli'];

      final username = _nameController.text;
      final email = _emailController.text;
      final alamat = _alamatController.text;

      final response =
          await authservice.updateProfile(userId, username, alamat, email);

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Berhasil")),
        );
         Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ProfilePage()),
      );
    });
      }
    } catch (e) {
      print('Failed to update profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text('No profile data available'),
                );
              }

              final userData = snapshot.data!;
              _nameController.text = userData['username'] ?? '_';
              _alamatController.text = userData['alamat'] ?? '_';
              _emailController.text = userData['email'] ?? '_';

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Gambar Profil dengan Tombol Edit
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _imageFile != null
                                  ? Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    )
                                  : const Image(
                                      image: AssetImage(
                                          'assets/photo/defaultAvatar.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (_) => SafeArea(
                                      child: Wrap(
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.camera),
                                            title: const Text("Take a photo"),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.camera);
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_library),
                                            title: const Text(
                                                "Choose from gallery"),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Text Field Nama
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: "Nama",
                              border: InputBorder.none,
                              hintText: userData['username'] ?? '_'),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Text Field Phone
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextField(
                          controller: _alamatController,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            border: InputBorder.none,
                            hintText: userData['alamat'] ?? '_',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Text Field Email
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              border: InputBorder.none,
                              hintText: userData['email'] ?? '_'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Tombol Save dan Cancel
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _saveProfile();
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
 
            );
  }
}
