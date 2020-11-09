import 'package:flutter/material.dart';
import 'package:repository/dao/base_dao.dart';
import 'package:repository/dao/setting_dao.dart';
import 'package:repository/model/mapper.dart';
import 'package:repository/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const currentLocaleLanguageCodeKey = 'key_current_locale_country_code';

class SettingDaoImpl extends BaseDao implements SettingDao {
  SettingDaoImpl({@required SharedPreferences preferences})
      : super(mapper: Mapper.none(), prefs: preferences);

  @override
  String getCurrentLocaleLanguageCode() {
    final languageCode = getString(currentLocaleLanguageCodeKey);
    return languageCode;
  }
}
