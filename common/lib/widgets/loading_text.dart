import 'package:flutter/material.dart';
import 'package:common/widgets/widgets.dart';

class LoadingText extends StatefulWidget {
  final String? text;
  final TextStyle textStyle;
  final Duration? showAfter;

  LoadingText({
    Key? key,
    this.text,
    required this.textStyle,
    this.showAfter,
  }) : super(key: key);

  @override
  State<LoadingText> createState() {
    return _LoadingTextState();
  }
}

class _LoadingTextState extends State<LoadingText> {
  bool _isShowing = true;

  @override
  void initState() {
    super.initState();

    if (widget.showAfter != null) {
      _isShowing = false;
      Future.delayed(widget.showAfter!, () {
        setState(() {
          _isShowing = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isShowing) {
      return const SizedBox();
    }

    return widget.text != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.text!,
                style: widget.textStyle,
              ),
              JumpingDotsProgressIndicator(
                fontSize: widget.textStyle.fontSize ?? 13,
                color: widget.textStyle.color ?? Colors.black,
              )
            ],
          )
        : JumpingDotsProgressIndicator(
            fontSize: widget.textStyle.fontSize ?? 13,
            color: widget.textStyle.color ?? Colors.black,
          );
  }
}
