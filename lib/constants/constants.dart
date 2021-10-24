export 'keys.dart';
export 'app_icons.dart';
export 'app_images.dart';
export 'app_sounds.dart';
export 'screens.dart';
export 'strings.dart';
export 'app_colors.dart';

import 'dart:math';
import 'package:flutter/material.dart';

const AppBarGradient = LinearGradient(
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

const String kTermsAndConditionURL = 'https://example.com/m_terms.html';
const String kAppSologan = '''Boilerplate is just a beginning''';