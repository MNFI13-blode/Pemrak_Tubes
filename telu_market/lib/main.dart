import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tel-U Market',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginScreen(),
    );
  }
}
