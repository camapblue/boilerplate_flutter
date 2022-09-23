import 'package:common/animated/animated_controller.dart';
import 'package:flutter/material.dart';

class FadeInTransition extends StatefulWidget {
  final Widget child;
  final AnimatedController controller;

  FadeInTransition({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  State<FadeInTransition> createState() => _FadedInTransitionState();
}

class _FadedInTransitionState extends State<FadeInTransition>
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
  void didUpdateWidget(FadeInTransition oldWidget) {
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
      duration: widget.controller.duration,
    );
    _animation = _tween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _setUpController();
  }

  void _setUpController() {
    widget.controller.runAnimation ??= () {
      _animationController.forward();
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
