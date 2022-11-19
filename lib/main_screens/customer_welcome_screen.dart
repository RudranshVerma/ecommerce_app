import 'package:flutter/material.dart';

import '../widgtes/yellow_button.dart';

class CustomerWelcomeScreen extends StatefulWidget {
  const CustomerWelcomeScreen({super.key});

  @override
  State<CustomerWelcomeScreen> createState() => _CustomerWelcomeScreenState();
}

class _CustomerWelcomeScreenState extends State<CustomerWelcomeScreen> {
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
                const Text(
                  'WELCOME',
                  style: TextStyle(color: Colors.white, fontSize: 30),
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
                              const Image(
                                  image: AssetImage('images/inapp/logo.jpg')),
                              YellowButton(
                                label: 'Log In',
                                width: 0.25,
                                onPressed: () {},
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
