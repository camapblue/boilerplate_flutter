import 'package:flutter/material.dart';

extension TextThemeData on ThemeData {
  /* Base TextTheme */
  TextTheme get thinTextTheme => textTheme;
  /* ***** */

  /* TextStyle */
  // Common
  TextTheme get numberTextTheme => textTheme;

  // Tabbar Menu
  TextStyle get bottomTabbarTextStyle => primaryTextTheme.headline1;

  // Loading Text
  TextStyle get loadingTextStyle =>
      primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);

  // Primary style
  TextStyle get primaryRegular => primaryTextTheme.bodyText1;
  TextStyle get primaryThin => primaryTextTheme.caption;
  TextStyle get primaryLight => primaryTextTheme.bodyText2;
  TextStyle get primaryMedium => primaryTextTheme.headline1;
  TextStyle get primaryBold => primaryTextTheme.headline2;
  TextStyle get primaryItalic => primaryTextTheme.subtitle1;
  TextStyle get primaryBoldItalic => primaryTextTheme.subtitle2;
  TextStyle get primaryButton => primaryTextTheme.button;
}