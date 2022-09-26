// ignore_for_file: constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppConstants {
  static const AppBarGradient = LinearGradient(
    colors: [
      Color(0xffbc4e83),
      Color(0xfff80759),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0, 1],
    tileMode: TileMode.clamp,
    transform: GradientRotation(pi / 2),
  );

  static const String TermsAndConditionURL = 'https://example.com/m_terms.html';
  static const String AppSologan = '''Boilerplate is just a beginning''';

  static final balanceFormatter = NumberFormat.currency(
    name: 'VND',
    symbol: '₫',
    decimalDigits: 0,
    locale: 'vi',
  );
}