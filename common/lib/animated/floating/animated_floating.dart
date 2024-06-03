import 'package:flutter/material.dart';

class AnimatedFloating extends StatelessWidget {
  final Widget child;
  final double from;
  final double to;
  final Duration duration;
  final void Function()? onEnd;

  const AnimatedFloating({
    super.key,
    required this.child,
    this.from = 80,
    this.to = 0,
    this.duration = const Duration(milliseconds: 250),
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: Offset(0.0, from), end: Offset(0.0, to)),
      curve: Curves.easeInOut,
      duration: duration,
      onEnd: onEnd,
      builder: (_, Offset value, Widget? child) {
        return Transform.translate(offset: value, child: child);
      },
      child: child,
    );
  }
}