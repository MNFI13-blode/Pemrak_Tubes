import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignUpState();
}

class _SignUpState extends State<Signup> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode userPasswordFocus = FocusNode();
  final FocusNode userCPasswordFocus = FocusNode();

  Color usernameColor = Colors.grey.withOpacity(0.2);
  Color passwordColor = Colors.grey.withOpacity(0.2);
  Color passwordColorC = Colors.grey.withOpacity(0.2);
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
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
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
                    controller: confirmPassword,
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
                              onPressed: () {},
                              child: const Text(
                                "LOGIN",
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
                                builder: (context) => const Signup(),
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
