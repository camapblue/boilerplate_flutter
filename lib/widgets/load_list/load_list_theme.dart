import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

extension LoadListTheme on ThemeData {
  TextStyle get loadListEmptyMessageTextStyle =>
      primaryTextTheme.bodyText1.copyWith(color: darkColor);
      
  TextStyle get loadListErrorMessageTextStyle =>
      primaryTextTheme.bodyText1.copyWith(color: darkColor);
}