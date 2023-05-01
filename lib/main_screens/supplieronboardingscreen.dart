import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierOnboardingscreen extends StatefulWidget {
  const SupplierOnboardingscreen({Key? key}) : super(key: key);

  @override
  State<SupplierOnboardingscreen> createState() =>
      _SupplierOnboardingscreenState();
}

class _SupplierOnboardingscreenState extends State<SupplierOnboardingscreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Timer? countDowntimer;
  int seconds = 3;
  List<int> discountList = [];
  String supplierId = '';
  @override
  void initState() {
    startTimer();
    _prefs.then((SharedPreferences prefs) {
      return prefs.getString('supplierid') ?? '';
    }).then((String value) {
      setState(() {
        supplierId = value;
      });
      print(supplierId);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    countDowntimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
      });
      if (seconds < 0) {
        stopTimer();
        supplierId != ''
            ? Navigator.pushReplacementNamed(context, '/supplier_home')
            : Navigator.pushReplacementNamed(context, '/supplier_login');
      }
      //   print(timer.tick);
      //   print(seconds);
    });
  }

  void stopTimer() {
    countDowntimer!.cancel();
  }

  Widget buildAsset() {
    return Image.asset('images/onboard/supplieronboard.JPEG');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildAsset(),
          Positioned(
            top: 60,
            right: 30,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade600.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                onPressed: () {
                  stopTimer();
                  supplierId != ''
                      ? Navigator.pushReplacementNamed(
                          context, '/supplier_home')
                      : Navigator.pushReplacementNamed(
                          context, '/supplier_login');
                },
                child:
                    seconds < 1 ? const Text('Skip') : Text('Skip | $seconds'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
