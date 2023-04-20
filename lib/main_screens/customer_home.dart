import 'package:ecommerce_app/main_screens/cart.dart';
import 'package:ecommerce_app/main_screens/category.dart';
import 'package:ecommerce_app/main_screens/home.dart';
import 'package:ecommerce_app/main_screens/profile.dart';
import 'package:ecommerce_app/main_screens/stores.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart' as badges;

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const ProfileScreen(
        // documentId: FirebaseAuth.instance.currentUser!.uid,
        ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeStyle: const badges.BadgeStyle(
                  padding: EdgeInsets.all(2),
                  badgeColor: Colors.yellow,
                ),
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                child: const Icon(Icons.shopping_cart)),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // telling that i have tapped on this icon
          });
        },
      ),
    );
  }
}
