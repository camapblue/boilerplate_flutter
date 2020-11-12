import 'package:flutter/material.dart';
import 'theme.dart';

/* Button Theme */

enum ButtonSize { big, medium, small }

enum ButtonThemeStyle { normal, light }

double buttonHeightByButtonSize(ButtonSize size) {
  switch (size) {
    case ButtonSize.big:
      return 60;
    case ButtonSize.medium:
      return 40;
    case ButtonSize.small:
      return 32;
  }
  return 54;
}

double fontSizeByButtonSize(ButtonSize size) {
  switch (size) {
    case ButtonSize.big:
      return 32;
    case ButtonSize.medium:
      return 20;
    case ButtonSize.small:
      return 16;
  }
  return 22;
}

BoxBorder buttonBorderByButtonSize(ButtonSize size,
    {bool disabled = false,
    Color borderColor = whiteColor,
    Color disabledBorderColor = lightGrayColor}) {
  final color = disabled ? disabledBorderColor : borderColor;
  switch (size) {
    case ButtonSize.big:
      return Border.all(width: 4, color: color);
    case ButtonSize.medium:
      return Border.all(width: 3, color: color);
    case ButtonSize.small:
      return Border.all(width: 2, color: color);
  }
  return Border.all(width: 3, color: color);
}

BorderRadius buttonBorderRadiusByButtonSize(ButtonSize size) {
  switch (size) {
    case ButtonSize.big:
      return BorderRadius.circular(16);
    case ButtonSize.medium:
      return BorderRadius.circular(12);
    case ButtonSize.small:
      return BorderRadius.circular(10);
  }
  return BorderRadius.circular(12);
}

/* ********** */

class BounceButtonTheme {
  final Color color;
  final Color lightColor;
  final Color disabledColor;
  final TextStyle normalTextStyle;
  final TextStyle disabledTextStyle;

  BounceButtonTheme(
      {this.color,
      this.lightColor,
      this.disabledColor,
      this.normalTextStyle,
      this.disabledTextStyle});

  BounceButtonTheme copyWith(
      {Color color,
      Color lightColor,
      Color disabledColor,
      TextStyle normalTextStyle,
      TextStyle disabledTextStyle}) {
    return BounceButtonTheme(
        color: color ?? this.color,
        lightColor: lightColor ?? this.lightColor,
        disabledColor: disabledColor ?? this.disabledColor,
        normalTextStyle: normalTextStyle ?? this.normalTextStyle,
        disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle);
  }
}

class BounceButtonDecoration {
  final double height;
  final double fontSize;
  final BoxBorder border;
  final BorderRadius borderRadius;

  BounceButtonDecoration(
      {this.height, this.fontSize, this.border, this.borderRadius});

  BounceButtonDecoration.size(ButtonSize size,
      {bool disabled = false,
      Color borderColor = whiteColor,
      Color disabledBorderColor = lightGrayColor,
      double fontSize})
      : height = buttonHeightByButtonSize(size),
        border = buttonBorderByButtonSize(size,
            disabled: disabled,
            borderColor: borderColor,
            disabledBorderColor: disabledBorderColor),
        borderRadius = buttonBorderRadiusByButtonSize(size),
        fontSize = fontSize ?? fontSizeByButtonSize(size);
}

extension BounceButtonThemeData on ThemeData {
  TextTheme get _buttonTextTheme => textTheme;
  TextStyle get _normalTextStyle => _buttonTextTheme.bodyText1;
  TextStyle get _disabledTextStyle =>
      _buttonTextTheme.bodyText1.copyWith(color: lightGrayColor);

  TextStyle get numberTextStyle1 => numberTextTheme.headline1;
  TextStyle get numberTextStyle2 => numberTextTheme.headline2;
  TextStyle get numberTextStyle3 => numberTextTheme.headline3;

  BounceButtonTheme get greenButtonTheme => BounceButtonTheme(
      color: greenColor,
      lightColor: greenColorLight,
      disabledColor: grayColor,
      normalTextStyle: _normalTextStyle,
      disabledTextStyle: _disabledTextStyle);

  BounceButtonTheme get redButtonTheme => BounceButtonTheme(
        color: redColor,
        lightColor: redColorLight,
        normalTextStyle: _normalTextStyle,
        disabledTextStyle: _disabledTextStyle,
      );

  BounceButtonTheme get blueButtonTheme => BounceButtonTheme(
        color: blueColor,
        lightColor: blueColorLight,
        normalTextStyle: _normalTextStyle,
        disabledTextStyle: _disabledTextStyle,
      );

  BounceButtonTheme get yellowButtonTheme => BounceButtonTheme(
        color: yellowColor,
        lightColor: yellowColorLight,
        normalTextStyle: _normalTextStyle.copyWith(color: darkColor),
        disabledTextStyle: _disabledTextStyle,
      );

  BounceButtonTheme get iconButtonTheme1 => BounceButtonTheme(
        color: greenColor,
        lightColor: greenColorLight,
        normalTextStyle: numberTextStyle1,
        disabledTextStyle: _disabledTextStyle,
      );

  BounceButtonTheme get iconButtonTheme2 => BounceButtonTheme(
        color: greenColor,
        lightColor: greenColorLight,
        normalTextStyle: numberTextStyle2,
        disabledTextStyle: _disabledTextStyle,
      );

  BounceButtonTheme get iconButtonTheme3 => BounceButtonTheme(
        color: greenColor,
        lightColor: greenColorLight,
        normalTextStyle: numberTextStyle3,
        disabledTextStyle: _disabledTextStyle,
      );
}
