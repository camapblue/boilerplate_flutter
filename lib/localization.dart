import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  const SLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) async {
    final localeName =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();

    final localizations = S(localeName);
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(SLocalizationsDelegate old) => false;
}

class S {
  S(this.localeName);

  Future<bool> load(Locale locale) async {
    final data =
        await rootBundle.loadString('lib/i18n/$localeName.json');
    final Map<String, dynamic> _result = json.decode(data);

    _sentences = Map();
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  // ignore: prefer_constructors_over_static_methods
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S) ?? S(null);
  }

  final String localeName;
  Map<String, String> _sentences;

  String translate(String key, {List<dynamic> params = const []}) {
    if (localeName == null) {
      return key;
    }
    return _sentences[key] == null ? key : sprintf(_sentences[key], params);
  }
}
