import 'package:flutter/material.dart';

extension PopupDrawerTheme on ThemeData {
  // PopUpDrawer
  TextStyle get popupDrawerTitleTextStyle => primaryTextTheme.headline1;
  TextStyle get popupDrawerContentDefaultTextStyle =>
      primaryTextTheme.bodyText1;
  TextStyle get popupDrawerContentBoldTextStyle => primaryTextTheme.headline1;
  TextStyle get popupDrawerContentItalicTextStyle => primaryTextTheme.bodyText2;
  TextStyle get popupDrawerTextItemStyle => primaryTextTheme.bodyText1;
}
