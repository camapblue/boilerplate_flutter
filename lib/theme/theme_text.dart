import 'package:flutter/material.dart';

class ThemeText {
  static TextStyle numberTextStyle = const TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto'
  );

  static TextTheme getNumberTextTheme({bool isLightTheme = true}) =>
      const TextTheme(
        titleLarge: TextStyle(fontSize: 20.0, fontFamily: 'Roboto'),
        titleMedium: TextStyle(fontSize: 15.0, fontFamily: 'Roboto'),
        titleSmall: TextStyle(fontSize: 12.0, fontFamily: 'Roboto'),
        bodyLarge: TextStyle(fontSize: 20.0, fontFamily: 'Roboto'),
        bodyMedium: TextStyle(fontSize: 15.0, fontFamily: 'Roboto'),
        bodySmall: TextStyle(fontSize: 12.0, fontFamily: 'Roboto'),
        labelLarge: TextStyle(fontSize: 20.0, fontFamily: 'Roboto'),
        labelMedium: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
        labelSmall: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
      ).apply(
        bodyColor: isLightTheme ? Colors.grey.shade600 : Colors.grey.shade400,
        displayColor:
            isLightTheme ? Colors.grey.shade600 : Colors.grey.shade400,
      );

  static TextTheme getDefaultTextTheme({bool isLightTheme = true}) =>
      const TextTheme(
        displayLarge: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w400),
        displayMedium: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        //Edit text style
        titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
        titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
        bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        //Button style
        labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ).apply(
        bodyColor: isLightTheme ? Colors.grey.shade600 : Colors.grey.shade400,
        displayColor:
            isLightTheme ? Colors.grey.shade600 : Colors.grey.shade400,
      );
}
