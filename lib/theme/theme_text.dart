import 'package:flutter/material.dart';

class ThemeText {
  static TextTheme getDefaultTextTheme() => const TextTheme(
        displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
        displayMedium: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        //Edit text style
        titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        //Button style
        labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ).apply(
        bodyColor: const Color(0xFF3A4A64),
        displayColor: const Color(0xFF3A4A64),
      );
}
