import 'package:flutter/material.dart';

import 'base_theme.dart';
import 'theme_text.dart';

class LightTheme extends BaseTheme {
  final int _primaryColor = 0xFFe07043;

  @override
  ColorScheme get colorScheme {
    return ColorScheme.light(
      primary: Color(_primaryColor),
      onPrimary: Colors.white,
      secondary: Colors.cyanAccent.shade700,
      onSecondary: Colors.white,
      tertiary: Colors.redAccent.shade200,
      onTertiary: Colors.white,
      background: Colors.grey.shade200,
      onBackground: Colors.grey.shade700,
      surface: Colors.white,
      onSurface: Colors.grey.shade700,
    );
  }

  @override
  TextTheme get textTheme => ThemeText.getDefaultTextTheme();
}
