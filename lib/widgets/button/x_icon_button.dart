import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

class XIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final double? iconSize;
  final double? minWidth;
  final Color? iconColor;
  final BoxBorder? border;
  final Color? background;
  final Color? hoverColor;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final double? splashRadius;

  const XIconButton({
    super.key,
    this.icon,
    this.child,
    this.border,
    this.minWidth,
    this.iconSize,
    this.padding,
    this.onPressed,
    this.iconColor,
    this.background,
    this.hoverColor,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        splashRadius: splashRadius ?? (minWidth ?? 45) - 25,
        iconSize: iconSize ?? 22,
        padding: padding ?? EdgeInsets.zero,
        hoverColor: hoverColor,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 45,
          minHeight: minWidth ?? 45,
        ),
        icon: child ??
            Icon(
              icon,
              color: iconColor ?? context.iconColor,
            ),
      ),
    );
  }
}
