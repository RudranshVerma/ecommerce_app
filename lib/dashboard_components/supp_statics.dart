import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/static_model.dart';

class StaticsScreen extends StatelessWidget {
  const StaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('deliverystatus', isEqualTo: 'preparing')
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

          num itemCount = 0;
          for (var item in snapshot.data!.docs) {
            itemCount += item['orderqty'];
          }
          double totalPrice = 0.0;
          for (var item in snapshot.data!.docs) {
            totalPrice += item['orderqty'] * item['orderprice'];
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const AppbarTitle(title: "Statstics"),
              leading: const AppBarBackButton(),
            ),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StaticsModel(
                      label: 'Sold out',
                      value: snapshot.data!.docs.length,
                      decimal: 0,
                    ),
                    StaticsModel(
                      label: 'item count',
                      value: itemCount,
                      decimal: 0,
                    ),
                    StaticsModel(
                      label: 'total balance',
                      value: totalPrice,
                      decimal: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
            ),
          );
        });
  }
}
