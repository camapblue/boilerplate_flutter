import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/repository/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDao _settingDao;
  final String _supportedLanguages;

  SettingRepositoryImpl(
      {@required SettingDao settingDao, @required String supportedLanguges})
      : _settingDao = settingDao,
        _supportedLanguages = supportedLanguges;

  @override
  Locale getCurrentLocale() {
    final languageCode = _settingDao.getCurrentLocaleLanguageCode();

    return languageCode != null ? Locale(languageCode) : const Locale('en');
  }

  @override
  List<Locale> getSupportedLocales() {
    return _supportedLanguages.split(',').map((c) => Locale(c)).toList();
  }
}
