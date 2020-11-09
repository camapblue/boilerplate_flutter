import 'dart:ui';
import 'dart:core';

import 'package:flutter/material.dart';

/* Action base colors */
const Color greenColor = Color(0xff4caf50);
const Color greenColorLight = Color(0xffa5d6a7);

const Color redColor = Color(0xfff44336);
const Color redColorLight = Color(0xffef9a9a);

const Color blueColor = Color(0xff2196f3);
const Color blueColorLight = Color(0xff90caf9);

const Color yellowColor = Color(0xffffeb3b);
const Color yellowColorLight = Color(0xfffff59d);

const Color orangeColor = Color(0xffff9800);
const Color orangeColorLight = Color(0xffffcc80);

const Color purpleColor = Color(0xff9c27b0);
const Color purpleColorLight = Color(0xffce93d8);
/* ***************** */

/* Light & Dark */
const Color whiteColor = Color(0xfffefefe);
const Color lightColor = Color(0xffdedede);

const Color darkGrayColor = Color(0xff6a6a6a);
const Color grayColor = Color(0xff9a9a9a);
const Color lightGrayColor = Color(0xffaaaaaa);

const Color darkColor = Color(0xff4a4a4a);
const Color blackColor = Color(0xff0a0a0a);
/* ***************** */

/* Fonts */
const String _primaryFont = 'NeoSansIntel';
const String _secondaryFont = 'Androgyne';
const String _thinFont = 'FjallaOne';
const String _numberFont = 'FjallaOneIcons';
const String _numberFont2 = 'Avenir';
const String _numberIconsFont1 = 'BangerIcons';
const String _numberIconsFont2 = 'FjallaOneIcons';
const String _numberIconsFont3 = 'BauhausIcons';
const String _accentFont1 = 'Bauhaus';
const String _accentFont2 = 'SoupofJustice';
const String _adsFont = 'NeoSansIntel';

const String defaultFont = 'Bauhaus';

/* ********* */

/* Text Theme */
const TextTheme primaryTextTheme = TextTheme(
    bodyText1: TextStyle(
        fontFamily: _primaryFont,
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyText2: TextStyle(
        fontFamily: _primaryFont,
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic),
    button: TextStyle(
        fontFamily: _primaryFont,
        color: whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w400),
    headline1: TextStyle(
        fontFamily: _primaryFont,
        color: whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w700),
    headline2: TextStyle(
        fontFamily: _primaryFont,
        color: whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic),
    subtitle1:
        TextStyle(fontFamily: _secondaryFont, color: whiteColor, fontSize: 16),
    subtitle2:
        TextStyle(fontFamily: _secondaryFont, color: greenColor, fontSize: 16));

const TextTheme secondaryTextTheme = TextTheme(
    bodyText1:
        TextStyle(fontFamily: _thinFont, color: whiteColor, fontSize: 15),
    bodyText2:
        TextStyle(fontFamily: _thinFont, color: greenColor, fontSize: 15));

const TextTheme numberTextTheme = TextTheme(
    bodyText1:
        TextStyle(fontFamily: _numberFont, color: whiteColor, fontSize: 15),
    bodyText2: TextStyle(
        fontFamily: _numberFont2,
        color: whiteColor,
        fontSize: 15,
        fontStyle: FontStyle.normal),
    headline1: TextStyle(
        fontFamily: _numberIconsFont1, color: whiteColor, fontSize: 15),
    headline2: TextStyle(
        fontFamily: _numberIconsFont2, color: whiteColor, fontSize: 15),
    headline3: TextStyle(
        fontFamily: _numberIconsFont3, color: whiteColor, fontSize: 15));

const TextTheme accentTextTheme = TextTheme(
  bodyText1: TextStyle(
      fontFamily: _accentFont1,
      color: whiteColor,
      fontSize: 15,
      fontWeight: FontWeight.w400),
  subtitle1: TextStyle(
      fontFamily: _accentFont2, color: whiteColor, fontSize: 15, height: 1.1),
  headline1: TextStyle(
      fontFamily: _accentFont1,
      color: whiteColor,
      fontSize: 15,
      fontWeight: FontWeight.w700),
);

const TextTheme adsTextTheme = TextTheme(
    bodyText1: TextStyle(
        fontFamily: _adsFont,
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyText2: TextStyle(
        fontFamily: _adsFont,
        color: greenColor,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    headline1: TextStyle(
        fontFamily: _adsFont,
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w700),
    headline2: TextStyle(
        fontFamily: _adsFont,
        color: greenColor,
        fontSize: 15,
        fontWeight: FontWeight.w700));

/* ********** */

