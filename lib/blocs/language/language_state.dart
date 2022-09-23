part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  final Locale locale;
  final List<Locale> supportedLocales;

  const LanguageState(this.locale, this.supportedLocales);

  @override
  List<Object> get props => [locale, supportedLocales];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(Locale locale, List<Locale> supportedLocales)
      : super(locale, supportedLocales);
}

class LanguageUpdateSuccess extends LanguageState {
  const LanguageUpdateSuccess(Locale locale, List<Locale> supportedLocales)
      : super(locale, supportedLocales);
}
