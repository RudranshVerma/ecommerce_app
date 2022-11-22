import 'package:flutter/material.dart';

class MyMessageHandler {
  // ignore: no_leading_underscores_for_local_identifiers
  static void showSnackBar(var _scaffoldKey, String message) {
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.yellow,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          )),
    );
  }
}
