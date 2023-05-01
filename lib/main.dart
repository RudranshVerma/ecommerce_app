import 'package:ecommerce_app/auth/customer_login.dart';
import 'package:ecommerce_app/auth/supplier_signup.dart';
import 'package:ecommerce_app/main_screens/customeronboardingscreen.dart';
import 'package:ecommerce_app/main_screens/profile.dart';
import 'package:ecommerce_app/main_screens/supplieronboardingscreen.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/id_provider.dart';
import 'package:ecommerce_app/providers/sql_helper.dart';
import 'package:ecommerce_app/providers/stripe_id.dart';
import 'package:ecommerce_app/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'auth/customer_signup.dart';
import 'auth/supplier_login.dart';
import 'main_screens/customer_home.dart';
import 'main_screens/supplier_home.dart';
import 'main_screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  SQLHelper.getDatabase;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    ChangeNotifierProvider(create: (_) => Wish()),
    ChangeNotifierProvider(create: (_) => IdProvider()),
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
        '/profile': (context) => const ProfileScreen(),
        '/supplieronboardingscreen': (context) =>
            const SupplierOnboardingscreen(),
        '/customeronboardingscreen': (context) =>
            const CustomerOnboardingscreen(),
        // '/supplierwelcomescreen': (context) => const SupplierWelcomeScreen(),
        // '/customerwelcomescreen': (context) => const CustomerWelcomeScreen(),
        '/customer_signup': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_login': (context) => const SupplierLogin(),
        '/supplier_signup': (context) => const SupplierRegister(),
      },
    );
  }
}
