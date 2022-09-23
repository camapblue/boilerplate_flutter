import 'package:flutter/material.dart';

extension LoadListTheme on ThemeData {
  TextStyle get loadListEmptyMessageTextStyle =>
      textTheme.titleMedium!.copyWith(color: Colors.black);

  TextStyle get loadListErrorMessageTextStyle =>
      textTheme.titleMedium!.copyWith(color: Colors.black);
}
