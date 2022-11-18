// import 'package:ecommerce_app/main_screens/dashboard.dart';
// import 'package:flutter/material.dart';

// class SupplierWelcomeScreen extends StatefulWidget {
//   const SupplierWelcomeScreen({super.key});

//   @override
//   State<SupplierWelcomeScreen> createState() => _SupplierWelcomeScreenState();
// }

// class _SupplierWelcomeScreenState extends State<SupplierWelcomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('images/inapp/bgimage.jpg'),
//                   fit: BoxFit.cover)),
//           constraints: const BoxConstraints.expand(),
//           child: SafeArea(
//               child: Column(children: [
//             const Text(
//               'WELCOME',
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//             const SizedBox(
//               height: 120,
//               width: 200,
//               child: Image(image: AssetImage('images/inapp/logo.jpg')),
//             ),
//             const Text(
//               'Shop',
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                   color: Colors.white38,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(50),
//                       bottomLeft: Radius.circular(50))),
//               child: const Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   'Supplier login',
//                   style: TextStyle(
//                       color: Colors.yellowAccent,
//                       fontSize: 26,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             Container(
//                 height: 60,
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 decoration: const BoxDecoration(
//                     color: Colors.white38,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(50),
//                         bottomLeft: Radius.circular(50))),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Image(image: AssetImage('images/inapp/logo.jpg')),
//                       YellowButton(
//                           label: 'Log In', onPressed: () {}, width: 0.25),
//                       Padding(
//                           padding: const EdgeInsets.only(right: 8),
//                           child: YellowButton(
//                               label: 'Sign Up', onPressed: () {}, width: 0.25)),
//                     ]))
//           ]))),
//     );
//   }
// }
