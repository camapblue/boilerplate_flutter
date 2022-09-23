import 'dart:ui';

abstract class SettingRepository {
  // Language
  Locale getCurrentLocale();

  List<Locale> getSupportedLocales();
}
