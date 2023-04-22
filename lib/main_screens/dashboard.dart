import 'dart:core';

import 'package:ecommerce_app/dashboard_components/edit_business.dart';
import 'package:ecommerce_app/dashboard_components/manage_products.dart';

import 'package:ecommerce_app/dashboard_components/supp_balance.dart';
import 'package:ecommerce_app/dashboard_components/supp_statics.dart';
import 'package:ecommerce_app/dashboard_components/supp_orders.dart';
import 'package:ecommerce_app/minor_screens/visit_store.dart';
import 'package:ecommerce_app/providers/auth_repo.dart';
import 'package:ecommerce_app/widgtes/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';

List<String> label = [
  'MY STORE',
  'ORDERS',
  'EDIT PROFILE',
  'MANAGE PRODUCTS',
  'BALANCE',
  'STATSTICS'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings_applications,
  Icons.attach_money,
  Icons.show_chart,
];
List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrders(),
  const EditBusiness(),
  const ManageProducts(),
  const BalanceScreen(),
  const StaticsScreen(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppbarTitle(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
              onPressed: () {
                MyAlertDialog.showMyDialog(
                    context: context,
                    title: 'Log Out',
                    content: 'Are you sure to log out ?',
                    tabNo: () {
                      Navigator.pop(context);
                    },
                    tabYes: () async {
                      await AuthRepo.logOut();
                      await Future.delayed(const Duration(microseconds: 100))
                          .whenComplete(() {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, '/welcomescreen');
                      });
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      size: 50,
                      color: Colors.yellowAccent,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          fontFamily: 'Acme'),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
