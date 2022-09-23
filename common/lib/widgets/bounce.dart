import 'package:flutter/widgets.dart';

enum BounceScale { bigger, smaller }

class Bounce extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  final Alignment alignment;
  final BounceScale bounceScale;
  final bool usingPointerDetector;
  final bool supportLongPress;

  Bounce({
    Key? key,
    required this.child,
    required this.onPressed,
    this.bounceScale = BounceScale.smaller,
    this.alignment = Alignment.center,
    this.usingPointerDetector = false,
    this.supportLongPress = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BounceState();
  }
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  bool _autoReverse = false;
  bool _startLongPress = false;
  bool _isCanceling = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(
        () {
          if (_autoReverse && _controller.value == _controller.upperBound) {
            _autoReverse = false;
            _controller.reverse();
          } else {
            if (_controller.status == AnimationStatus.dismissed &&
                widget.onPressed != null) {
              if (!_isCanceling) {
                widget.onPressed!();
              } else {
                _isCanceling = false;
              }

              if (widget.supportLongPress && _startLongPress) {
                _autoReverse = true;
                _controller.forward();
              }
            }
          }
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(dynamic event) {
    _controller.forward();
  }

  void _onTapUp(dynamic event) {
    _proceedTapUp();
  }

  void _proceedTapUp() {
    if (_controller.value < _controller.upperBound) {
      _autoReverse = true;
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onPressed == null) {
      return widget.child;
    }

    return widget.usingPointerDetector
        ? Listener(
            onPointerDown: _onTapDown,
            onPointerUp: _onTapUp,
            onPointerCancel: (_) {
              if (!widget.supportLongPress) {
                _isCanceling = true;
                _proceedTapUp();
              }
            },
            child: widget.supportLongPress
                ? GestureDetector(
                    onLongPress: () {
                      _startLongPress = true;
                      _controller.reverse();
                    },
                    onLongPressUp: () {
                      _startLongPress = false;
                      _proceedTapUp();
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        _scale = widget.bounceScale == BounceScale.smaller
                            ? 1 - _controller.value
                            : 1 + _controller.value;

                        return Transform.scale(
                          scale: _scale,
                          child: child,
                        );
                      },
                      child: widget.child,
                    ),
                  )
                : AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    _scale = widget.bounceScale == BounceScale.smaller
                        ? 1 - _controller.value
                        : 1 + _controller.value;

                    return Transform.scale(
                      scale: _scale,
                      child: child,
                    );
                  },
                  child: widget.child,
                ),
          )
        : GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: () {
              if (!widget.supportLongPress) {
                _isCanceling = true;
                _proceedTapUp();
              }
            },
            onLongPress: widget.supportLongPress
                ? () {
                    _startLongPress = true;
                    _controller.reverse();
                  }
                : null,
            onLongPressUp: widget.supportLongPress
                ? () {
                    _startLongPress = false;
                    _proceedTapUp();
                  }
                : null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                _scale = widget.bounceScale == BounceScale.smaller
                    ? 1 - _controller.value
                    : 1 + _controller.value;

                return Transform.scale(
                  scale: _scale,
                  child: child,
                );
              },
              child: widget.child,
            ),
          );
  }
}
