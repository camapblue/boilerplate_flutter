import 'package:flutter/material.dart';

class InkWellButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final double borderRadius;
  final Border? border;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? backgroundColor;
  final Widget child;

  const InkWellButton({
    super.key,
    required this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(4),
    this.borderRadius = 4,
    this.border,
    this.hoverColor,
    this.highlightColor,
    this.backgroundColor,
    this.splashColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final extraRadius =
        border != null ? (border!.top.width / 10.0) * borderRadius : 0.0;
    final outerBorderRadius = borderRadius + extraRadius;
    final borderHeight = border != null ? border!.top.width * 2 : 0.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(outerBorderRadius),
        color: backgroundColor ?? Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(outerBorderRadius),
            border: border,
          ),
          child: InkWell(
            onTap: onTap,
            hoverColor: hoverColor,
            highlightColor: highlightColor ?? Colors.white54,
            splashColor: splashColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: width,
              height: height != null ? height! - borderHeight : null,
              padding: padding,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
