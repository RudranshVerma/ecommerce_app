import 'package:ecommerce_app/main_screens/customer_home.dart';
import 'package:flutter/material.dart';
import 'main_screens/customer_welcome_screen.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/supplier_welcome_screen.dart';
import 'main_screens/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SupplierWelcomeScreen(),
      // home: SupplierHomeScreen(),
      // home: CustomerWelcomeScreen(),
      home: WelcomeScreen(),
    );
  }
}
