// ignore_for_file: library_private_types_in_public_api

import 'package:ecommerce_app/customers_screens/customers_orders.dart';
import 'package:ecommerce_app/customers_screens/wishlist.dart';
import 'package:ecommerce_app/main_screens/cart.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.yellow, Colors.brown])),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: constraints.biggest.height <= 120
                          ? 1
                          : 0, // account can disappear and reappear with opacity on scrolling
                      child: const Text(
                        'Account',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.yellow, Colors.brown])),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/inapp/guest.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'guest'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 24),
                                    ),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CartScreen(
                                              back: AppBarBackButton(),
                                            )));
                              },
                            ),
                          ),
                          Container(
                            color: Colors.yellow,
                            child: TextButton(
                              child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Orders',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                    ),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomerOrders()));
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: const Center(
                                    child: Text(
                                      'Wishlist',
                                      style: TextStyle(
                                          color: Colors.yellow, fontSize: 20),
                                    ),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WhishlistScreen()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                            child: Image(
                              image: AssetImage('images/inapp/logo.jpg'),
                            ),
                          ),
                          const ProfileHeaderLabel(headerlabel: 'Account Info'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(children: const [
                                RepeatedListTile(
                                    icon: Icons.email,
                                    subtitle: 'example@email.com',
                                    title: 'Email Address'),
                                YellowDivider(),
                                RepeatedListTile(
                                    icon: Icons.phone,
                                    subtitle: '+91',
                                    title: 'Phone No'),
                                YellowDivider(),
                                RepeatedListTile(
                                    icon: Icons.location_pin,
                                    subtitle: '23-R Nehru Place,New Delhi',
                                    title: 'Address'),
                              ]),
                            ),
                          ),
                          const ProfileHeaderLabel(
                              headerlabel: 'Account Settings'),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(children: [
                                RepeatedListTile(
                                  title: 'Edit Profile',
                                  subtitle: '',
                                  icon: Icons.edit,
                                  onPressed: () {},
                                ),
                                const YellowDivider(),
                                RepeatedListTile(
                                  title: 'Change Password',
                                  icon: Icons.edit,
                                  onPressed: () {},
                                ),
                                const YellowDivider(),
                                RepeatedListTile(
                                    title: 'Log out',
                                    icon: Icons.logout,
                                    onPressed: () async {
                                      showCupertinoDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoAlertDialog(
                                          title: const Text('Log Out'),
                                          content: const Text(
                                              'Are you sure to log out ?'),
                                          actions: <CupertinoDialogAction>[
                                            CupertinoDialogAction(
                                              /// This parameter indicates this action is the default,
                                              /// and turns the action's text to bold text.
                                              isDefaultAction: true,
                                              onPressed: () {
                                                Navigator.popAndPushNamed(
                                                    context,
                                                    '/customerwelcomescreen');
                                              },
                                              child: const Text('No'),
                                            ),
                                            CupertinoDialogAction(
                                              /// This parameter indicates the action would perform
                                              /// a destructive action such as deletion, and turns
                                              /// the action's text color to red.
                                              isDestructiveAction: true,
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                // ignore: use_build_context_synchronously
                                                Navigator.pushReplacementNamed(
                                                    context, '/welcomescreen');
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile({
    Key? key,
    required this.icon,
    this.onPressed,
    this.subtitle = '',
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerlabel;
  const ProfileHeaderLabel({
    Key? key,
    required this.headerlabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
              width: 50,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Text(
              headerlabel,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 40,
              width: 50,
              child: Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            )
          ],
        ));
  }
}
