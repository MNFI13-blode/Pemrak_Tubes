import 'package:flutter/material.dart';
import 'package:telu_market/home.dart';
import 'package:telu_market/stripe_service.dart';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  StripeService.init();
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
      home: HomeScreen(),
    );
  }
}
