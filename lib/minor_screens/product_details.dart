// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/main_screens/cart.dart';
import 'package:ecommerce_app/main_screens/visit_store.dart';
import 'package:ecommerce_app/minor_screens/full_screen_view.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:ecommerce_app/widgtes/yellow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({super.key, this.proList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imageList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenView(imagesList: imageList),
                      ),
                    );
                  },
                  child: Stack(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Swiper(
                        pagination: const SwiperPagination(
                            builder: SwiperPagination.fraction),
                        itemBuilder: (context, index) {
                          return Image(
                            image: NetworkImage(imageList[index]),
                          );
                        },
                        itemCount: imageList.length,
                      ),
                    ),
                    Positioned(
                        left: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )),
                    Positioned(
                        right: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        )),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.proList['proname'],
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'USD',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.proList['price'].toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                                size: 30,
                              )),
                        ],
                      ),
                      Text(
                        (widget.proList['instock'].toString()) +
                            (' pieces  available in stock '),
                        style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      ),
                      const ProDetailsHeader(
                        label: '   Item Description   ',
                      ),
                      Text(
                        widget.proList['prodesc'],
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      const ProDetailsHeader(
                        label: '   Similar Items   ',
                      ),
                      SizedBox(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _prodcutsStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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

                            return SingleChildScrollView(
                              child: StaggeredGridView.countBuilder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, index) {
                                    return ProductModel(
                                      products: snapshot.data!.docs[index],
                                    );
                                  },
                                  staggeredTileBuilder: (context) =>
                                      const StaggeredTile.fit(1)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisitStore(
                                      suppId: widget.proList['sid'])));
                        },
                        icon: const Icon(Icons.store)),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen(
                                        back: AppBarBackButton(),
                                      )));
                        },
                        icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
                // IconButton(
                //     onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                YellowButton(
                    label: 'ADD TO CART',
                    onPressed: () {
                      context.read<Cart>().addItem(
                            widget.proList['proname'],
                            widget.proList['price'],
                            1,
                            widget.proList['instock'],
                            widget.proList['proimages'],
                            widget.proList['proid'],
                            widget.proList['sid'],
                          );
                    },
                    width: 0.5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailsHeader extends StatelessWidget {
  final String label;
  const ProDetailsHeader({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Divider(
                color: Colors.yellow.shade900,
                thickness: 1,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                  color: Colors.yellow.shade900,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
              width: 50,
              child: Divider(
                color: Colors.yellow.shade900,
                thickness: 1,
              ),
            )
          ],
        ));
  }
}
