import 'package:flutter/material.dart';

class BounceTransition extends AnimatedWidget {
  final double from;
  final double to;
  final Widget child;

  BounceTransition({
    Key? key,
    required this.child,
    required Animation<double> animation,
    this.from = 0.0,
    this.to = 1.0,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final _animation = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(
        parent: listenable as Animation<double>,
        curve: Curves.easeInOutBack,
      ),
    );

    return Transform.scale(
      scale: _animation.value,
      child: child,
    );
  }
}
