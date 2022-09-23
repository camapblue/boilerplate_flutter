import 'package:common/animated/animated_controller.dart';
import 'package:flutter/material.dart';

class FlickerTransition extends StatefulWidget {
  final Widget child;
  final AnimatedController controller;

  FlickerTransition({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  State<FlickerTransition> createState() => _FlickerTransitionState();
}

class _FlickerTransitionState extends State<FlickerTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final Tween<double> _tween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();

    _createAnimations();
  }

  @override
  void didUpdateWidget(FlickerTransition oldWidget) {
    super.didUpdateWidget(oldWidget);

    _setUpController();
  }

  @override
  void dispose() {
    _animationController
      ..stop()
      ..dispose();

    widget.controller.dispose();

    super.dispose();
  }

  void _createAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = _tween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _setUpController();
  }

  void _setUpController() {
    widget.controller.runAnimation ??= () async {
      await _animationController
          .repeat(reverse: true, period: widget.controller.duration)
          .orCancel;
    };
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
