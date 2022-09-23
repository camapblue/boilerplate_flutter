part of 'language_bloc.dart';

abstract class LanguageEvent {
  const LanguageEvent();
}

class LanguageUpdated extends LanguageEvent {
  final Locale newLanguage;

  const LanguageUpdated(this.newLanguage);
}
