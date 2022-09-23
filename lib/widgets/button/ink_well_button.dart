import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? highlightColor;
  final Color? splashColor;
  final Widget child;

  InkWellButton({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(4),
    this.borderRadius = 4,
    this.highlightColor,
    this.splashColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        highlightColor: highlightColor ?? whiteColor.withOpacity(0.54),
        splashColor: splashColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
