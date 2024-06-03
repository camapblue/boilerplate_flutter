import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/material.dart';

extension AppContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  static ScreenSize screenSize = ScreenSize.big;

  String translate(
    String key, {
    String suffix = '',
    List<dynamic> params = const [],
    bool checkNumberParams = false,
  }) {
    return S.of(this).translate(
          key,
          suffix: suffix,
          params: params,
          checkNumberParams: checkNumberParams,
        );
  }

  double responsiveSized(double size) {
    return size * screenSize.ratio();
  }

  double responsiveSizes(List<double> sizes) {
    return sizes[screenSize.index];
  }

  /// ----------- Text style ----------- ///

  TextStyle? get displayLarge => theme.textTheme.displayLarge;

  TextStyle? get displayMedium => theme.textTheme.displayMedium;

  TextStyle? get displaySmall => theme.textTheme.displaySmall;

  TextStyle? get headlineLarge => theme.textTheme.headlineLarge;

  TextStyle? get headlineMedium => theme.textTheme.headlineMedium;

  TextStyle? get headlineSmall => theme.textTheme.headlineSmall;

  TextStyle? get titleLarge => theme.textTheme.titleLarge;

  TextStyle? get titleMedium => theme.textTheme.titleMedium;

  TextStyle? get titleSmall => theme.textTheme.titleSmall;

  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;

  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;

  TextStyle? get bodySmall => theme.textTheme.bodySmall;

  TextStyle? get labelLarge => theme.textTheme.labelLarge;

  TextStyle? get labelMedium => theme.textTheme.labelMedium;

  TextStyle? get labelSmall => theme.textTheme.labelSmall;

  /// ----------- Colors ----------- ///

  bool get isLightTheme => theme.colorScheme.brightness == Brightness.light;

  // Primary (orange)
  Color get primaryColor => theme.colorScheme.primary;

  Color get onPrimaryColor => theme.colorScheme.onPrimary;

  // Secondary (cygan)
  Color get secondaryColor => theme.colorScheme.secondary;

  Color get onSecondaryColor => theme.colorScheme.onSecondary;

  // Tertiary (light red)
  Color get tertiaryColor => theme.colorScheme.tertiary;

  Color get onTertiaryColor => theme.colorScheme.onTertiary;

  // Error
  Color get errorColor => theme.colorScheme.error;

  // shimmer
  Color get shimmerBaseColor => theme.colorScheme.primary;

  Color get shimmerHighlightColor => theme.colorScheme.primary;

  // background
  Color get backgroundColor => theme.colorScheme.surface;

  Color get onBackgroundColor => theme.colorScheme.surface;

  // surface (background of card or something similar)
  Color get surfaceColor => theme.colorScheme.surface;

  Color get onSurfaceColor => theme.colorScheme.onSurface;

  //

  Color get dividerColor => theme.dividerColor;

  Color get cardColor => theme.cardColor;

  Color get disabledColor => theme.disabledColor;

  Color get borderColor => theme.disabledColor.withOpacity(.6);

  Color get textColor =>
      theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurface;

  Color? get iconColor => theme.iconTheme.color;

  Color get textColorDisabled => textColor.withOpacity(.3);

  Color get primaryColorDark => theme.colorScheme.primaryContainer;
}
