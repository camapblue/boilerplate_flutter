import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/theme/theme.dart';
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
    super.key,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  const XText.displayLarge(
    this.text, {
    super.key,
    this.textAlign = TextAlign.start,
    this.xStyle = TextStyleEnum.displayLarge,
    this.style,
    this.overflow,
    this.maxLines,
  });

  const XText.displayMedium(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.displayMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.displaySmall(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.displaySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineLarge(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.headlineLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineMedium(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.headlineMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.headlineSmall(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.headlineSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleLarge(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.titleLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleMedium(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.titleMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.titleSmall(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.titleSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodyLarge(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.bodyLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodyMedium(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.bodyMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.bodySmall(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.bodySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelLarge(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.labelLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelMedium(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.labelMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  const XText.labelSmall(
    this.text, {
    super.key,
    this.xStyle = TextStyleEnum.labelSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

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
    FontWeight? fontWeight,
  }) {
    final currentStyle = style ?? xStyle.getTextStyle(context);
    return XText(
      text,
      key: key,
      xStyle: xStyle,
      style: currentStyle?.copyWith(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory XText.diamondIcon({Color? color, double? fontSize}) {
    var style = ThemeText.getNumberTextTheme().bodyMedium;
    if (color != null) {
      style = style?.copyWith(color: color);
    }
    if (fontSize != null) {
      style = style?.copyWith(fontSize: fontSize);
    }
    return XText(
      '@',
      style: style,
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
