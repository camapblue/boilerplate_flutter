import 'package:flutter/material.dart';

import 'app_context.dart';

enum TextStyleEnum {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

extension TextStyleEnumExtension on TextStyleEnum {
  TextStyle? getTextStyle(BuildContext context) {
    switch (this) {
      case TextStyleEnum.displayLarge:
        return context.displayLarge;
      case TextStyleEnum.displayMedium:
        return context.displayMedium;
      case TextStyleEnum.displaySmall:
        return context.displaySmall;
      case TextStyleEnum.headlineLarge:
        return context.headlineLarge;
      case TextStyleEnum.headlineMedium:
        return context.headlineMedium;
      case TextStyleEnum.headlineSmall:
        return context.headlineSmall;
      case TextStyleEnum.titleLarge:
        return context.titleLarge;
      case TextStyleEnum.titleMedium:
        return context.titleMedium;
      case TextStyleEnum.titleSmall:
        return context.titleSmall;
      case TextStyleEnum.bodyLarge:
        return context.bodyLarge;
      case TextStyleEnum.bodyMedium:
        return context.bodyMedium;
      case TextStyleEnum.bodySmall:
        return context.bodySmall;
      case TextStyleEnum.labelLarge:
        return context.labelLarge;
      case TextStyleEnum.labelMedium:
        return context.labelMedium;
      case TextStyleEnum.labelSmall:
        return context.labelSmall;
      default:
        return context.bodyMedium;
    }
  }
}