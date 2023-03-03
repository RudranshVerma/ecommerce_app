import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final dynamic count;
  final int decimal;
  const AnimatedCounter(
      {super.key, required this.count, required this.decimal});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _controller;
    setState(() {
      _animation = Tween(begin: _animation.value, end: widget.count)
          .animate(_controller);
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
            child: Text(
          _animation.value.toStringAsFixed(widget.decimal),
          style: const TextStyle(
            color: Colors.pink,
            fontSize: 40,
            fontFamily: 'Acme',
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ));
      },
    );
  }
}
