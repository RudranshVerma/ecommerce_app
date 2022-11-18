import 'package:ecommerce_app/main_screens/category.dart';
import 'package:ecommerce_app/main_screens/dashboard.dart';
import 'package:ecommerce_app/main_screens/home.dart';
import 'package:ecommerce_app/main_screens/store.dart';
import 'package:flutter/material.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({Key? key}) : super(key: key);

  @override
  SupplierHomeScreenState createState() => SupplierHomeScreenState();
}

class SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashboardScreen(),
    Center(
      child: Text('upload'),
    )
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
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
