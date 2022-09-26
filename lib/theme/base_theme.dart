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
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.background,
      indicatorColor: onPrimarySurfaceColor,
      errorColor: colorScheme.error,
      textTheme: textTheme,
      applyElevationOverlayColor: isDark,
      useMaterial3: true,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Color(0xFF8992A2)),
      disabledColor: Colors.grey,
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

  String get fontFamily => 'NeoSansIntel';
}
