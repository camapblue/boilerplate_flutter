import 'package:flutter/material.dart';

import 'theme_text.dart';

abstract class BaseTheme {
  ThemeData build(BuildContext context) {
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final Color primarySurfaceColor =
        isDark ? colorScheme.surface : colorScheme.primary;
    final Color onPrimarySurfaceColor =
        isDark ? colorScheme.onSurface : colorScheme.onPrimary;
        
    return ThemeData(
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      primaryColor: primarySurfaceColor,
      canvasColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.22),
      dialogBackgroundColor: colorScheme.surface,
      indicatorColor: onPrimarySurfaceColor,
      textTheme: textTheme,
      applyElevationOverlayColor: isDark,
      useMaterial3: true,
      appBarTheme: appBarTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      iconTheme: const IconThemeData(color: Color(0xFF8992A2)),
      disabledColor: const Color(0xffdadada),
    );
  }

  ColorScheme get colorScheme => const ColorScheme.light();

  TextTheme get textTheme => ThemeText.getDefaultTextTheme();

  AppBarTheme get appBarTheme => AppBarTheme(
        elevation: 0,
        toolbarTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      );
  
  BottomAppBarTheme get bottomAppBarTheme =>
      BottomAppBarTheme(color: colorScheme.surface);

  String get fontFamily => 'NeoSansIntel';
}
