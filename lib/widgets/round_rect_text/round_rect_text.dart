import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/constants/app_colors.dart';
import 'package:boilerplate_flutter/theme/theme.dart';

class RoundRectText extends StatelessWidget {
  final String text;
  final double height;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Gradient gradient;
  final int maxLines;

  const RoundRectText({
    @required this.text,
    @required this.height,
    this.padding = const EdgeInsets.all(4),
    this.textStyle,
    this.borderRadius,
    this.backgroundColor = Colors.transparent,
    this.gradient,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          style: textStyle ?? theme.primaryRegular,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  factory RoundRectText.standard({
    @required BuildContext context,
    @required String text,
    int maxLines,
  }) {
    final theme = Theme.of(context);

    return RoundRectText(
      text: text,
      height: maxLines == null ? 18 : maxLines * 18.0 - 4.0,
      textStyle: theme.primaryRegular.copyWith(fontSize: 12),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      backgroundColor: AppColors.pink,
      maxLines: maxLines,
    );
  }

  factory RoundRectText.corner({
    @required BuildContext context,
    @required String text,
    Color backgroundColor,
    Color textColor,
    int maxLines,
  }) {
    final theme = Theme.of(context);

    return RoundRectText(
      text: text,
      height: maxLines == null ? 16 : maxLines * 16.0 - 4.0,
      textStyle: theme.primaryBold.copyWith(
        fontSize: 10.7,
        color: textColor ?? AppColors.pink,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      backgroundColor: backgroundColor ?? AppColors.pink.withOpacity(0.1),
      borderRadius: BorderRadius.circular(3.6),
      maxLines: maxLines,
    );
  }

  factory RoundRectText.gradient({
    @required BuildContext context,
    @required String text,
    double fontSize = 8,
    double height = 14,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
    Gradient gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.pink,
        AppColors.pinkLight,
      ],
    ),
    Color textColor = Colors.white,
  }) {
    final theme = Theme.of(context);

    return RoundRectText(
      text: text,
      height: height,
      textStyle: theme.primaryBold.copyWith(
        fontSize: fontSize,
        color: textColor,
      ),
      padding: padding,
      gradient: gradient,
    );
  }

  factory RoundRectText.skeleton({
    @required final BuildContext context,
    @required final double height,
  }) {
    return RoundRectText(
      text: '',
      height: height,
      backgroundColor: Colors.white,
    );
  }
}
