import 'package:flutter/material.dart';

class FadingWithPlaceholder extends StatefulWidget {
  final Widget? placeholder;
  final Widget child;
  final Duration? delayToShow;
  final Duration duration;

  const FadingWithPlaceholder({
    Key? key,
    this.placeholder,
    this.delayToShow,
    this.duration = const Duration(milliseconds: 350),
    required this.child,
  }) : super(key: key);

  @override
  State<FadingWithPlaceholder> createState() {
    return _FadingWithPlaceholderState();
  }
}

class _FadingWithPlaceholderState extends State<FadingWithPlaceholder> {
  bool _isStart = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.placeholder != null) {
        if (widget.delayToShow != null) {
          await Future.delayed(widget.delayToShow!);
        }
        if (mounted) {
          setState(() {
            _isStart = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.placeholder == null) {
      return widget.child;
    }

    return AnimatedSwitcher(
      duration: widget.duration,
      child: _isStart ? widget.child : widget.placeholder,
    );
  }
}
