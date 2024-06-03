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
  final bool loading;
  final int? maxLines;

  const XButton({
    super.key,
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
    this.loading = false,
    this.maxLines,
  });

  const XButton.primary({
    super.key,
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
    this.loading = false,
    this.maxLines,
  });

  const XButton.positive({
    super.key,
    this.type = XButtonType.positive,
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
    this.loading = false,
    this.maxLines,
  });

  const XButton.negative({
    super.key,
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
    this.loading = false,
    this.maxLines,
  });

  const XButton.outlined({
    super.key,
    this.style = XButtonStyle.outline,
    this.onPressed,
    this.title,
    this.child,
    this.color,
    this.solidTextColor,
    this.padding,
    this.borderRadius,
    this.width,
    this.suffixIcon,
    this.prefixIcon,
    this.loading = false,
    this.maxLines,
    this.type = XButtonType.positive,
    this.prefixIconColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? _getColor(context);
    final xRadius = borderRadius ?? BorderRadius.circular(8);
    final isEnabled = onPressed != null;
    final textColor = _getTextColor(context, primaryColor);

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
                    color: _getBorderColor(context),
                    width: 2.0,
                  ),
                )
              : BoxDecoration(
                  borderRadius: xRadius,
                  color: context.onBackgroundColor,
                  border: Border.all(
                    color: context.borderColor,
                    width: 1.0,
                  ),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: XText.labelMedium(
                      title,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                    ).customWith(
                      context,
                      color: isEnabled ? textColor : context.disabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (suffixIcon != null && !loading) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ] else if (loading) ...[
                    const SizedBox(width: 8),
                    _loadingIcon(textColor),
                  ],
                ],
              )),
        ),
      ),
    );
  }

  Widget _loadingIcon(Color color) {
    return SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
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

  Color _getBorderColor(BuildContext context) {
    switch (style) {
      case XButtonStyle.solid:
      case XButtonStyle.outline:
        return color ?? _getColor(context);
      case XButtonStyle.text:
        return context.primaryColor;
      default:
        return context.borderColor;
    }
  }

  Color _getBackgroundColor(BuildContext context, Color primaryColor) {
    switch (style) {
      case XButtonStyle.solid:
        return color ?? _getColor(context);
      case XButtonStyle.outline:
      case XButtonStyle.text:
        return Colors.transparent;
      default:
        return primaryColor;
    }
  }

  Color _getTextColor(BuildContext context, Color primaryColor) {
    switch (style) {
      case XButtonStyle.solid:
        return solidTextColor ?? Colors.white;
      case XButtonStyle.outline:
      case XButtonStyle.text:
        return primaryColor;
      default:
        return primaryColor;
    }
  }
}
