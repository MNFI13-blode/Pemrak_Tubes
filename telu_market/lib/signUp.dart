import 'package:flutter/material.dart';
import 'login.dart';
import 'authservice/authService.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignUpState();
}

class _SignUpState extends State<Signup> {
  final username1 = TextEditingController();
  final password1 = TextEditingController();
  final confirmPassword1 = TextEditingController();
  final email1 = TextEditingController();
  final alamat1 = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode userPasswordFocus = FocusNode();
  final FocusNode userCPasswordFocus = FocusNode();
  final FocusNode userEmail = FocusNode();
  final FocusNode userAlamat = FocusNode();

  Color emailColor = Colors.grey.withOpacity(0.2);
  Color usernameColor = Colors.grey.withOpacity(0.2);
  Color passwordColor = Colors.grey.withOpacity(0.2);
  Color passwordColorC = Colors.grey.withOpacity(0.2);
  Color alamatColor = Colors.grey.withOpacity(0.2);
  Color buttonColor = const Color.fromARGB(255, 207, 59, 48);

  bool isVisible = false;
  bool isVisible1 = false;
  @override
  void initState() {
    super.initState();
    userNameFocus.addListener(() {
      setState(() {
        usernameColor = userNameFocus.hasFocus
            ? const Color.fromARGB(255, 197, 57, 47).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2);
      });
    });

    userCPasswordFocus.addListener(() {
      setState(() {
        passwordColorC = userCPasswordFocus.hasFocus
            ? const Color.fromARGB(255, 197, 57, 47).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2);
      });
    });

    userPasswordFocus.addListener(() {
      setState(() {
        passwordColor = userPasswordFocus.hasFocus
            ? const Color.fromARGB(255, 197, 57, 47).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2);
      });
    });
    userEmail.addListener(() {
      setState(() {
        emailColor = userEmail.hasFocus
            ? const Color.fromARGB(255, 197, 57, 47).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2);
      });
    });
    userAlamat.addListener(() {
      setState(() {
        alamatColor = userAlamat.hasFocus
            ? const Color.fromARGB(255, 197, 57, 47).withOpacity(0.2)
            : Colors.grey.withOpacity(0.2);
      });
    });
  }

  final Authservice authservice = Authservice();

  //fungsi register pembeli
  Future<void> registerPembelid() async {
    final username = username1.text;
    final email = email1.text;
    final password = password1.text;
    final alamat = alamat1.text;
    final confirmPassword = confirmPassword1.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        alamat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom harus diisi")),
      );
      return;
    }

       if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak cocok")),
      );
      return;
    }

    
    final response =
        await authservice.registerPembeli(username, email, alamat, password);

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Register Berhasil")),
      );
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
    } else {
      // print("Register gagal: ${response['message']}");
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi Kesalahan")),
      );
    }
  }

  @override
  void dispose() {
    username1.dispose();
    password1.dispose();
    userNameFocus.dispose();
    userPasswordFocus.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ListTile(
                  title: Text(
                    "Register New Account",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: usernameColor,
                      // color: const Color.fromARGB(255, 207, 59, 48).withOpacity(.2)
                    ),
                    child: TextFormField(
                      focusNode: userNameFocus,
                      controller: username1,
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
                    )),
                //===
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: emailColor,
                      // color: const Color.fromARGB(255, 207, 59, 48).withOpacity(.2)
                    ),
                    child: TextFormField(
                      focusNode: userEmail,
                      controller: email1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    )),
                //==alamat
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: alamatColor,
                      // color: const Color.fromARGB(255, 207, 59, 48).withOpacity(.2)
                    ),
                    child: TextFormField(
                      focusNode: userAlamat,
                      controller: alamat1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Alamat is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.house),
                        border: InputBorder.none,
                        hintText: "Alamat",
                      ),
                    )),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: passwordColor,
                    // color: const Color.fromARGB(255, 207, 59, 48).withOpacity(.2)
                  ),
                  child: TextFormField(
                    focusNode: userPasswordFocus,
                    controller: password1,
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: passwordColorC,
                    // color: const Color.fromARGB(255, 207, 59, 48).withOpacity(.2)
                  ),
                  child: TextFormField(
                    focusNode: userCPasswordFocus,
                    controller: confirmPassword1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is required";
                      }
                      return null;
                    },
                    obscureText: !isVisible1,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              //In here we will create a click to show and hide the password a toggle button
                              setState(() {
                                //toggle button
                                isVisible1 = !isVisible1;
                              });
                            },
                            icon: Icon(isVisible1
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                ),
                const SizedBox(height: 10),
                MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        buttonColor = const Color.fromARGB(255, 170, 7, 7);
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        buttonColor = const Color.fromARGB(255, 207, 59, 48);
                      });
                    },
                    child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 100),
                        tween: ColorTween(
                          begin: buttonColor,
                          end: buttonColor,
                        ),
                        builder: (context, Color? color, child) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: 55,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color ?? buttonColor,
                            ),
                            child: TextButton(
                              onPressed: registerPembelid,
                              child: const Text(
                                "Daftar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        })

                    //  child: Container(
                    //     height: 55,
                    //     width: MediaQuery.of(context).size.width * .9,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //          color: buttonColor),
                    //     child: TextButton(
                    //         onPressed: () {},
                    //         child: const Text(
                    //           "LOGIN",
                    //           style: TextStyle(color: Colors.white),
                    //         )),
                    //   ),
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          //Navigate to sign up
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 230, 186, 27)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
