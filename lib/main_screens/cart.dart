import 'package:ecommerce_app/main_screens/customer_home.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppbarTitle(title: 'Cart'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Cart is Empty!',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Material(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(25),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {
                  Navigator.pushReplacement(
                      // we do not need to add back button thats why pushReplacement
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomerHomeScreen()));
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Text(
                'Total:\$ ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '00.00:\$',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
        ),
        Container(
          height: 35,
          width: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(25)),
          child: MaterialButton(
            onPressed: () {},
            child: const Text('CHECKOUT'),
          ),
        )
      ]),
    );
  }
}
