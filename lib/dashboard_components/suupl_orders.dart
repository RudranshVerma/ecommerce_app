import 'package:ecommerce_app/dashboard_components/delivered.dart';
import 'package:ecommerce_app/dashboard_components/preparing.dart';
import 'package:ecommerce_app/dashboard_components/shipping.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:flutter/material.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: const AppbarTitle(title: "SupplierOrders"),
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppbarTitle(title: "Orders"),
          bottom: const TabBar(
              indicatorColor: Colors.yellow,
              indicatorWeight: 8,
              tabs: [
                RepeatedTab(label: 'Preparing'),
                RepeatedTab(label: 'Shipping'),
                RepeatedTab(label: 'Delivered')
              ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Shipping(),
          Delivered(),
        ]),
>>>>>>> c3c9564492cb27b2e1a753b4bb976c63e832a3f7
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Center(
            child: Text(label, style: const TextStyle(color: Colors.grey))));
  }
}
