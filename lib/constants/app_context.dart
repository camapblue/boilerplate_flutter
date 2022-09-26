import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppContext on BuildContext {
  static ScreenSize screenSize = ScreenSize.big;

  bool hasBloc<T extends Bloc>() {
    try {
      final _ = BlocProvider.of<T>(this);
      return true;
    } catch (_) {}
    return false;
  }

  double responsiveSized(double size) {
    return size * screenSize.ratio();
  }

  double responsiveSizes(List<double> sizes) {
    return sizes[screenSize.index];
  }
  
  ThemeData get theme => Theme.of(this);

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

  Color get primaryColor => theme.colorScheme.primary;

  Color get secondaryColor => theme.colorScheme.secondary;

  Color get errorColor => theme.colorScheme.error;

  Color get shimmerBaseColor => theme.colorScheme.primary;

  Color get shimmerHighlightColor => theme.colorScheme.primary;

  Color get dividerColor => theme.dividerColor;

  Color get onPrimary => theme.colorScheme.onPrimary;

  Color get onSecondary => theme.colorScheme.onSecondary;

  Color get cardColor => theme.cardColor;

  Color get unselectedWidgetColor => theme.unselectedWidgetColor;

  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;

  Color get backgroundColor => theme.backgroundColor;

  Color get disabledColor => theme.disabledColor;

  Color get disabledBackgroundColor => theme.disabledColor.withOpacity(.2);

  Color? get textColor => theme.textTheme.labelLarge?.color;

  Color? get iconColor => theme.iconTheme.color;
}