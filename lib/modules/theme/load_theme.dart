import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/theme/theme_constants.dart';

ThemeData loadTheme() {
  return ThemeData(
    primaryColor: redColor,
    primaryColorLight: redColorLight,
    tabBarTheme: const TabBarTheme(
      labelColor: redColor,
      unselectedLabelColor: grayColor,
    ),
    backgroundColor: lightColor,
    primaryTextTheme: appPrimaryTextTheme,
    textTheme: appSecondaryTextTheme,
    iconTheme: const IconThemeData(
      color: lightColor,
    ),
    appBarTheme: AppBarTheme(toolbarTextStyle: appSecondaryTextTheme.bodyText1),
  );
}
