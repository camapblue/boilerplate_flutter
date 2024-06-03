import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class RoundRectText extends StatelessWidget {
  final String text;
  final double height;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final Gradient? gradient;
  final int? maxLines;

  const RoundRectText({
    super.key,
    required this.text,
    required this.height,
    this.padding = const EdgeInsets.all(4),
    this.textStyle,
    this.borderRadius,
    this.backgroundColor = Colors.transparent,
    this.gradient,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient != null ? null : backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
        gradient: gradient,
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle ?? context.bodyMedium,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  factory RoundRectText.standard({
    required BuildContext context,
    required String text,
    int? maxLines,
  }) {
    return RoundRectText(
      text: text,
      height: maxLines == null ? 18 : maxLines * 18.0 - 4.0,
      textStyle: context.bodyMedium?.copyWith(fontSize: 12),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      backgroundColor: AppColors.neutral,
      maxLines: maxLines,
    );
  }

  factory RoundRectText.corner({
    required BuildContext context,
    required String text,
    Color? backgroundColor,
    Color? textColor,
    int? maxLines,
  }) {
    return RoundRectText(
      text: text,
      height: maxLines == null ? 16 : maxLines * 16.0 - 4.0,
      textStyle: context.bodyMedium?.copyWith(
        fontSize: 10.7,
        color: textColor ?? AppColors.neutral,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      backgroundColor: backgroundColor ?? AppColors.neutral.withOpacity(0.1),
      borderRadius: BorderRadius.circular(3.6),
      maxLines: maxLines,
    );
  }

  factory RoundRectText.gradient({
    required BuildContext context,
    required String text,
    double fontSize = 8,
    double height = 14,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
    Gradient gradient = AppConstants.AppBarGradient,
    Color textColor = Colors.white,
  }) {
    return RoundRectText(
      text: text,
      height: height,
      textStyle: context.bodyMedium?.copyWith(
        fontSize: 10.7,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      padding: padding,
      gradient: gradient,
    );
  }

  factory RoundRectText.skeleton({
    required final BuildContext context,
    required final double height,
  }) {
    return RoundRectText(
      text: '',
      height: height,
      backgroundColor: Colors.white,
    );
  }
}
