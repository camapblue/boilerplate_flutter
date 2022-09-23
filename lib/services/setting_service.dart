import 'dart:ui';

abstract class SettingService {
  // Language
  Locale getCurrentLocale();

  List<Locale> getSupportedLocales();
}