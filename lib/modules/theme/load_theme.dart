import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/theme/theme_constants.dart';

ThemeData loadTheme() {
  return ThemeData(
    primaryColor: redColor,
    primaryColorLight: redColorLight,
    accentColor: greenColor,
    tabBarTheme: const TabBarTheme(
      labelColor: redColor,
      unselectedLabelColor: grayColor,
    ),
    backgroundColor: lightColor,
    primaryTextTheme: appPrimaryTextTheme,
    textTheme: appSecondaryTextTheme,
    accentTextTheme: appAccentTextTheme,
    iconTheme: const IconThemeData(
      color: lightColor,
    ),
    appBarTheme: const AppBarTheme(textTheme: appSecondaryTextTheme),
  );
}
