import 'dart:convert';
import 'dart:ui';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
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
    final data = await rootBundle.loadString('lib/i18n/$localeName.json');
    final _result = Map<String, dynamic>.from(json.decode(data));

    _sentences = {};
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

  String translateText(TranslatedText text) {
    return translate(text.text, suffix: text.suffix, params: text.params);
  }

  String translate(
    String key, {
    String suffix = '',
    List<dynamic> params = const [],
    bool numberPrefix = false,
    bool numberSuffix = false,
  }) {
    if (localeName == null) {
      return '${sprintf(key, params)}$suffix';
    }
    if (!numberPrefix && !numberSuffix) {
      return _sentences[key] == null
          ? '${sprintf(key, params)}$suffix'
          : '${sprintf(_sentences[key], params)}$suffix';
    }

    if (numberPrefix) {
      final numberString = key.split(' ').first;
      if (numberString == null || !Validator.isNumeric(numberString)) {
        return _sentences[key] == null
            ? sprintf(key, params)
            : sprintf(_sentences[key], params);
      }
      final number = num.parse(numberString);
      final newKey = key.substring(numberString.length + 1);
      return sprintf('%d ${_sentences[newKey]}', [number]);
    }

    final numberString = key.split(' ').last;
    if (numberString == null || !Validator.isNumeric(numberString)) {
      return _sentences[key] == null
          ? sprintf(key, params)
          : sprintf(_sentences[key], params);
    }
    final number = num.parse(numberString);
    final newKey = key.substring(0, key.length - (numberString.length + 1));
    return sprintf('${_sentences[newKey]} %d', [number]);
  }
}
