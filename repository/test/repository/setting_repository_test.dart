import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/dao/dao.dart';

import 'package:repository/repository/impl/setting_repository_impl.dart';
import 'package:repository/repository/setting_repository.dart';

import 'setting_repository_test.mocks.dart';

@GenerateMocks([SettingDao])
void main() {
  final SettingDao settingDao = MockSettingDao();

  late SettingRepository settingRepository;
  const _supportedLanguages = 'vi,en,zh';

  setUp(() {
    settingRepository = SettingRepositoryImpl(
      settingDao: settingDao,
      supportedLanguges: _supportedLanguages,
    );
  });

  group('getCurrentLocale()', () {
    test('''
      return Locale instance in case get language code from SettingDao
    ''', () async {
      const locale = Locale('id');
      when(settingDao.getCurrentLocaleLanguageCode()).thenReturn('id');

      expect(settingRepository.getCurrentLocale(), locale);
    });
  });

  group('getSupportedLocales()', () {
    test('return list of Locales in case get from ThemeDao', () {
      const supportedLocales = [Locale('id'), Locale('en'), Locale('zh')];
      expect(settingRepository.getSupportedLocales(), supportedLocales);
    });
  });
}
