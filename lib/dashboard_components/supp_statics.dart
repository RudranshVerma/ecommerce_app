import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:flutter/material.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppbarTitle(title: "Statstics"),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
