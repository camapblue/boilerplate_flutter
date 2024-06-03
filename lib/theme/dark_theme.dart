import 'package:flutter/material.dart';

import 'base_theme.dart';
import 'theme_text.dart';

class DarkTheme extends BaseTheme {
  final int _primaryColor = 0xFFe07043;

  @override
  ColorScheme get colorScheme {
    return ColorScheme.dark(
      primary: Color(_primaryColor),
      onPrimary: Colors.white,
      secondary: Colors.cyanAccent.shade700,
      onSecondary: Colors.white,
      tertiary: Colors.redAccent.shade200,
      onTertiary: Colors.white,
      surface: Colors.grey.shade800,
      onSurface: Colors.grey.shade200,
    );
  }

  @override
  TextTheme get textTheme => ThemeText.getDefaultTextTheme(
    isLightTheme: false
  );
}
