import 'dart:ui';

abstract class LanguageEvent {
  const LanguageEvent();
}

class LanguageUpdated extends LanguageEvent {
  final Locale newLanguage;

  const LanguageUpdated(this.newLanguage);
}