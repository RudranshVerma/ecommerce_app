import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/minor_screens/visit_store.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import "package:flutter/material.dart";

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppbarTitle(title: 'Stores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('suppliers').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 25,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VisitStore(
                                      suppId: snapshot.data!.docs[index]['sid'],
                                    )));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Image.asset('images/inapp/store.jpg'),
                              ),
                              Positioned(
                                  bottom: 28,
                                  left: 10,
                                  child: SizedBox(
                                    height: 48,
                                    width: 100,
                                    child: Image.network(
                                      snapshot.data!.docs[index]['storelogo'],
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                            ],
                          ),
                          Text(
                              snapshot.data!.docs[index]['storename']
                                  .toLowerCase(),
                              style: const TextStyle(
                                fontSize: 26,
                                fontFamily: 'AkayaTelivigala',
                              ))
                        ],
                      ),
                    );
                  });
            }
            return const Center(
              child: Text('No Stores'),
            );
          },
        ),
      ),
    );
  }
}
