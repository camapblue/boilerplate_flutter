import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

enum XButtonType { primary, positive, negative }

enum XButtonStyle { outline, solid, text }

class XButton extends StatelessWidget {
  final XButtonType type;
  final XButtonStyle style;
  final GestureTapCallback? onPressed;
  final String? title;
  final Widget? child;
  final Color? color;
  final Color? prefixIconColor;
  final Color? solidTextColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const XButton({
    Key? key,
    this.type = XButtonType.primary,
    this.style = XButtonStyle.solid,
    this.onPressed,
    this.title,
    this.child,
    this.color,
    this.prefixIconColor,
    this.solidTextColor,
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  const XButton.primary({
    Key? key,
    this.type = XButtonType.primary,
    this.style = XButtonStyle.solid,
    this.onPressed,
    this.title,
    this.child,
    this.color,
    this.prefixIconColor,
    this.solidTextColor,
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.width,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  const XButton.positive({
    Key? key,
    this.type = XButtonType.positive,
    this.style = XButtonStyle.solid,
    this.onPressed,
    this.title,
    this.child,
    this.color = const Color(0xFF7ED321),
    this.prefixIconColor,
    this.solidTextColor = const Color(0xFF1C1D1E),
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  const XButton.negative({
    Key? key,
    this.type = XButtonType.negative,
    this.style = XButtonStyle.solid,
    this.onPressed,
    this.title,
    this.child,
    this.color,
    this.prefixIconColor,
    this.solidTextColor,
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? _getColor(context);
    final xRadius = borderRadius ?? BorderRadius.circular(100.0);
    final isEnabled = onPressed != null;

    return Material(
      color: _getBackgroundColor(context, primaryColor),
      borderRadius: xRadius,
      child: InkWell(
        borderRadius: xRadius,
        onTap: onPressed,
        child: Container(
          width: width,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
          decoration: isEnabled
              ? BoxDecoration(
                  borderRadius: xRadius,
                  border: Border.all(
                    color: _getBorderColor(context, primaryColor),
                    width: 1.0,
                  ),
                )
              : BoxDecoration(
                  borderRadius: xRadius,
                  color: context.disabledColor,
                ),
          child: child ??
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  XText.labelLarge(
                    title,
                  ).customWith(
                    context,
                    color: _getTextColor(context, primaryColor)
                        .withOpacity(isEnabled ? 1.0 : 0.7),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              )),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    switch (type) {
      case XButtonType.negative:
        return context.errorColor;
      case XButtonType.positive:
        return context.secondaryColor;
      case XButtonType.primary:
        return context.primaryColor;
      default:
        return context.disabledColor;
    }
  }

  Color _getBorderColor(BuildContext context, Color primaryColor) {
    switch (style) {
      case XButtonStyle.solid:
      case XButtonStyle.outline:
        return primaryColor;
      case XButtonStyle.text:
        return context.cardColor;
      default:
        return context.disabledColor;
    }
  }

  Color _getBackgroundColor(BuildContext context, Color primaryColor) {
    switch (style) {
      case XButtonStyle.solid:
        return _getColor(context);
      case XButtonStyle.outline:
      case XButtonStyle.text:
        return context.cardColor;
      default:
        return primaryColor;
    }
  }

  Color _getTextColor(BuildContext context, Color primaryColor) {
    switch (style) {
      case XButtonStyle.solid:
        return solidTextColor ?? context.cardColor;
      case XButtonStyle.outline:
      case XButtonStyle.text:
        return primaryColor;
      default:
        return primaryColor;
    }
  }
}
