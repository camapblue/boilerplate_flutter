import 'dart:convert';
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
        (locale.countryCode == null || locale.countryCode!.isEmpty)
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
    final result = Map<String, dynamic>.from(json.decode(data));

    _sentences = {};
    result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  // ignore: prefer_constructors_over_static_methods
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S) ?? S('en');
  }

  final String? localeName;
  Map<String, String> _sentences = {};

  String translateText(TranslatedText text) {
    return translate(text.text, suffix: text.suffix, params: text.params);
  }

  String translate(
    String key, {
    String suffix = '',
    List<dynamic>? params = const [],
    bool checkNumberParams = false,
  }) {
    if (localeName == null) {
      return '${sprintf(key, params)}$suffix';
    }
    if (!checkNumberParams) {
      return _sentences[key] == null
          ? '${sprintf(key, params)}$suffix'
          : '${sprintf(_sentences[key]!, params)}$suffix';
    }

    final comps = key.split(' ');
    var keyString = '';
    final numberParams = <dynamic>[];
    for (var i = 0; i < comps.length; i++) {
      final text = comps[i];
      if (Validator.isNumeric(text)) {
        numberParams.add(int.parse(text));
      } else {
        keyString += keyString.isEmpty ? text : ' $text';
      }
    }

    return _sentences[keyString] == null
        ? '${sprintf(keyString, numberParams)}$suffix'
        : '${sprintf(_sentences[keyString]!, numberParams)}$suffix';
  }
}
