import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/main_screens/category.dart';
import 'package:ecommerce_app/main_screens/dashboard.dart';
import 'package:ecommerce_app/main_screens/home.dart';
import 'package:ecommerce_app/main_screens/stores.dart';
import 'package:ecommerce_app/main_screens/upload_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  SupplierHomeScreenState createState() => SupplierHomeScreenState();
}

class SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    DashboardScreen(),
    const UploadProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            // .where('deliverystatus', isEqualTo: 'preparing')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

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
                      showBadge: snapshot.data!.docs.isEmpty ? false : true,
                      badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(2),
                        badgeColor: Colors.yellow,
                      ),
                      badgeContent: Text(
                        snapshot.data!.docs.length.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      child: const Icon(Icons.dashboard)),
                  label: 'Dashboard',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: 'Upload',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex =
                      index; // telling that i have tapped on this icon
                });
              },
            ),
          );
        });
  }
}
