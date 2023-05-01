// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../models/product_model.dart';

class MenGalleryScreen extends StatefulWidget {
  const MenGalleryScreen({Key? key}) : super(key: key);

  @override
  _MenGalleryScreenState createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<MenGalleryScreen> {
  // final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
  //     .collection('products')
  //     .where('maincateg', isEqualTo: 'men')
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('maincateg', isEqualTo: 'men')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return const Center(
              child: Text(
            'hello !',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acme',
                letterSpacing: 1.5),
          ));
        }

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text(
            'This category \n\n has no items yet !',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acme',
                letterSpacing: 1.5),
          ));
        }
        // return Text(snapshot.data!.docs[0]['price'].toString());
        return StaggeredGridView.countBuilder(
            itemCount: snapshot.data?.docs.length ?? 0,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return ProductModel(
                products: snapshot.data!.docs[index],
              );
            },
            staggeredTileBuilder: (context) => const StaggeredTile.fit(1));
      },
    );
  }
}
