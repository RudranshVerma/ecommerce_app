import 'package:flutter/material.dart';
import '../widgtes/appbar_widgets.dart';

class SubCategProducts extends StatelessWidget {
  final String maincategName;
  final String subcategName;
  const SubCategProducts(
      {super.key, required this.maincategName, required this.subcategName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarBackButton(),
        title: AppbarTitle(title: subcategName),
      ),
      body: Center(
        child: Text(maincategName),
      ),
    );
  }
}
