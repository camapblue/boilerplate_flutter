import 'package:flutter/material.dart';

import 'base_theme.dart';

class DefaultTheme extends BaseTheme {
  final int _primaryColor = 0xFF2957C8;
  final int _accentColor = 0xFF7ED321;

  @override
  ColorScheme get colorScheme {
    final primaryColorSwatch = MaterialColor(_primaryColor, <int, Color>{
      50: const Color(0xFFE5EBF8),
      100: const Color(0xFFBFCDEF),
      200: const Color(0xFF94ABE4),
      300: const Color(0xFF6989D9),
      400: const Color(0xFF4970D0),
      500: Color(_primaryColor),
      600: const Color(0xFF244FC2),
      700: const Color(0xFF1F46BB),
      800: const Color(0xFF193CB4),
      900: const Color(0xFF0F2CA7),
    });

    return ColorScheme.fromSwatch(
      primarySwatch: primaryColorSwatch,
      accentColor: Color(_accentColor),
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
    );
  }
}
