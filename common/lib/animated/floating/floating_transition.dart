import 'package:flutter/material.dart';

class FloatingTransition extends AnimatedWidget {
  final double from;
  final double to;
  final Widget child;

  const FloatingTransition({
    super.key,
    required this.child,
    required Animation<double> animation,
    this.from = -80.0,
    this.to = 0.0,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(
      begin: Offset(0.0, from),
      end: Offset(0.0, to),
    ).animate(
      CurvedAnimation(
        parent: listenable as Animation<double>,
        curve: Curves.easeInOutBack,
      ),
    );

    return Transform.translate(
      offset: animation.value,
      child: child,
    );
  }
}
