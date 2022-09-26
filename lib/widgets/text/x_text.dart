import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class XText extends StatelessWidget {
  final String? text;
  final TextStyleEnum xStyle;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const XText(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.displayLarge(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.xStyle = TextStyleEnum.displayLarge,
    this.style,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  const XText.displayMedium(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.displayMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.displaySmall(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.displaySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.headlineLarge(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.headlineLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.headlineMedium(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.headlineMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.headlineSmall(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.headlineSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.titleLarge(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.titleLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.titleMedium(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.titleMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.titleSmall(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.titleSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.bodyLarge(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.bodyLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.bodyMedium(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.bodySmall(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.bodySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.labelLarge(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.labelLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.labelMedium(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.labelMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  const XText.labelSmall(
    this.text, {
    Key? key,
    this.xStyle = TextStyleEnum.labelSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  factory XText.custom(
    String text, {
    Key? key,
    TextStyleEnum xStyle = TextStyleEnum.labelSmall,
    TextStyle? style,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return XText(
      text,
      key: key,
      xStyle: xStyle,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  XText customWith(
    BuildContext context, {
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
  }) {
    final currentStyle = style ?? xStyle.getTextStyle(context);
    return XText(
      text,
      key: key,
      xStyle: xStyle,
      style: currentStyle?.copyWith(
          color: color, fontSize: fontSize, fontStyle: fontStyle),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ?? xStyle.getTextStyle(context),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
