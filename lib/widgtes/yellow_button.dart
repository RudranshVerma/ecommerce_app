import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onpressed;
  final double width;
  const YellowButton(
      {Key? key,
      required this.label,
      required this.onpressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onpressed,
        child: const Text('CHECKOUT'),
      ),
    );
  }
}
