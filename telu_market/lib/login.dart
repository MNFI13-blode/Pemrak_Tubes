import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUp.dart';
import 'home.dart';
import './authservice/authService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final Authservice authservice = Authservice();
  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  @override
  void initState(){
     super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if(token != null){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    }
  }

  //Now we should call this function in login button
  // login() async {
  //   var response = await db
  //       .login(Users(usrName: username.text, usrPassword: password.text));
  //   if (response == true) {
  //     //If login is correct, then goto notes
  //     if (!mounted) return;
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const Notes()));
  //   } else {
  //     //If not, true the bool value to show error message
  //     setState(() {
  //       isLoginTrue = true;
  //     });
  //   }
  // }

  Future<void> loginPembeli() async {
    final username1 = username.text;
    final password1 = password.text;

    if (username1.isEmpty && password1.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua kolom wajib di isi')));
    }
    final response = await authservice.loginPembeli(username1, password1);
    if (response['status'] == 'success login') {
      String token = response['token'];
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login berhasil')));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
      print("Login berhasil, token: $token");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi Kesalahan")),
      );
      print("Login gagal: ${response['message']}");
    }
  }

  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //We put all our textfield to a form to be controlled and not allow as empty
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //Username field

                  //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                  Image.asset(
                    "lib/assets/login.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 197, 57, 47)
                            .withOpacity(0.2)),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),

                  //Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 197, 57, 47)
                            .withOpacity(0.2)),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                //In here we will create a click to show and hide the password a toggle button
                                setState(() {
                                  //toggle button
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  ),

                  const SizedBox(height: 10),
                  //Login button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 207, 59, 48)),
                    child: TextButton(
                        onPressed: loginPembeli,
                        //() {
                          // if (formKey.currentState!.validate()) {
                          //   //Login method will be here
                          //   loginPembeli();
                          //   // Navigator.pushReplacement(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //       builder: (context) =>
                          //   //           HomeScreen()), // Ganti dengan HomeScreen
                          //   // );
                          //   //Now we have a response from our sqlite method
                          //   //We are going to create a user
                          // }
                        // },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //Sign up button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            // Navigasi ke halaman signup
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()),
                            );
                          },
                          child: const Text("SIGN UP"))
                    ],
                  ),

                  // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                  isLoginTrue
                      ? const Text(
                          "Username or passowrd is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
