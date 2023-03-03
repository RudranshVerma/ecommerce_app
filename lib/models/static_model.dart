import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/_animatedCounter.dart' as animation;

class StaticsModel extends StatelessWidget {
  final String label;
  final int decimal;
  final dynamic value;
  const StaticsModel(
      {Key? key,
      required this.label,
      required this.value,
      required this.decimal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * .55,
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Center(
                child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
          ),
          Container(
            height: 90,
            width: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: animation.AnimatedCounter(
              count: value,
              decimal: decimal,
            ),
          ),
        ],
      )
    ]);
  }
}
