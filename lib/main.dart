import 'package:flutter/material.dart';
import 'auth/customer_signup.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/customer_welcome_screen.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/supplier_welcome_screen.dart';
import 'main_screens/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcomescreen',
      routes: {
        '/welcomescreen': (context) => const WelcomeScreen(),
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/supplier_home': (context) => const SupplierHomeScreen(),
        '/supplierwelcomescreen': (context) => const SupplierWelcomeScreen(),
        '/customerwelcomescreen': (context) => const CustomerWelcomeScreen(),
        '/customer_signup': (context) => const CustomerRegister(),
      },
    );
  }
}
