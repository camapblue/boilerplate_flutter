import 'package:flutter/material.dart';

class AnimatedBounce extends StatelessWidget {
  final Widget child;
  final double from;
  final double to;
  final Duration duration;
  final void Function()? onEnd;

  AnimatedBounce({
    Key? key,
    required this.child,
    this.from = 0.0,
    this.to = 1.0,
    this.duration = const Duration(milliseconds: 250),
    this.onEnd,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: from, end: to),
      curve: Curves.easeInOutBack,
      duration: duration,
      onEnd: onEnd,
      builder: (_, double value, Widget? child) {
        return Transform.scale(scale: value > 0 ? value : 0, child: child);
      },
      child: child,
    );
  }
}