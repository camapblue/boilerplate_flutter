import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  final Locale locale;
  final List<Locale> supportedLocales;

  LanguageState([this.locale, this.supportedLocales]);

  @override
  List<Object> get props => [locale, supportedLocales];
}

class LanguageInitial extends LanguageState {
  LanguageInitial(Locale locale, List<Locale> supportedLocales)
      : super(locale, supportedLocales);
}

class LanguageUpdateSuccess extends LanguageState {
  LanguageUpdateSuccess(Locale locale, List<Locale> supportedLocales)
      : super(locale, supportedLocales);
}
