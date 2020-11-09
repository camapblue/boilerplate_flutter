import 'package:flutter/material.dart';
import 'theme_constants.dart';

extension TextThemeData on ThemeData {
  /* Base TextTheme */
  // TextTheme get primaryTextTheme => primaryTextTheme;
  TextTheme get thinTextTheme => secondaryTextTheme;
  // TextTheme get accentTextTheme => accentTextTheme;
  /* ***** */

  /* TextStyle */
  // Common
  TextStyle get numberTextStyle => numberTextTheme.bodyText1;

  // Tabbar Menu
  TextStyle get bottomTabbarTextStyle => primaryTextTheme.headline1;

  // Loading Text
  TextStyle get loadingTextStyle =>
      primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);
}