import 'package:ecommerce_app/auth/customer_login.dart';
import 'package:ecommerce_app/auth/supplier_signup.dart';

import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'auth/customer_signup.dart';
import 'auth/supplier_login.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/customer_welcome_screen.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/supplier_welcome_screen.dart';
import 'main_screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    ChangeNotifierProvider(create: (_) => Wish()),
  ], child: const MyApp()));
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
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_login': (context) => const SupplierLogin(),
        '/supplier_signup': (context) => const SupplierRegister(),
      },
    );
  }
}
