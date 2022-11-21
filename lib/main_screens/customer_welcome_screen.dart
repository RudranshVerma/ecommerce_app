import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../widgtes/yellow_button.dart';
import 'package:ecommerce_app/main_screens/welcomescreen.dart';

class CustomerWelcomeScreen extends StatefulWidget {
  const CustomerWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerWelcomeScreen> createState() => _CustomerWelcomeScreenState();
}

class _CustomerWelcomeScreenState extends State<CustomerWelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/inapp/bgimage.jpg'),
                  fit: BoxFit.cover)),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/welcomescreen');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText('WELCOME',
                              textStyle: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Acme'),
                              colors: [
                                Colors.yellowAccent,
                                Colors.red,
                                Colors.blueAccent,
                                Colors.green,
                                Colors.purple,
                                Colors.teal,
                              ]),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    ),
                  ],
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('TO',
                        textStyle: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Acme'),
                        colors: [
                          Colors.yellowAccent,
                          Colors.red,
                          Colors.blueAccent,
                          Colors.green,
                          Colors.purple,
                          Colors.teal,
                        ]),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('LOCAL MARKET',
                        textStyle: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Acme'),
                        colors: [
                          Colors.yellowAccent,
                          Colors.red,
                          Colors.blueAccent,
                          Colors.green,
                          Colors.purple,
                          Colors.teal,
                        ]),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
                const SizedBox(
                  height: 120,
                  width: 200,
                  child: Image(image: AssetImage('images/inapp/logo.jpg')),
                ),
                const Text(
                  'Shop',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Customer login',
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedBuilder(
                                animation: _controller.view,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _controller.value * 2 * pi,
                                    child: child,
                                  );
                                },
                                child: const Image(
                                    image: AssetImage('images/inapp/logo.jpg')),
                              ),
                              YellowButton(
                                label: 'Log In',
                                width: 0.25,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/customer_home');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: YellowButton(
                                    label: 'Sign Up',
                                    onPressed: () {},
                                    width: 0.25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white38,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GoogleFacebookLogin(
                            label: 'GOOGLE',
                            onPressed: () {},
                            child: const Image(
                                image: AssetImage('images/inapp/google.jpg')),
                          ),
                          GoogleFacebookLogin(
                            label: 'FACEBOOK',
                            onPressed: () {},
                            child: const Image(
                                image: AssetImage('images/inapp/facebook.jpg')),
                          ),
                          GoogleFacebookLogin(
                              label: 'GUEST',
                              onPressed: () {},
                              child:
                                  // const Image(image: AssetImage('images/inapp/guest.jpg')),
                                  const Icon(
                                Icons.person,
                                size: 55,
                                color: Colors.lightBlueAccent,
                              )),
                        ]),
                  ),
                )
              ]))),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const GoogleFacebookLogin(
      {Key? key,
      required this.label,
      required this.child,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
