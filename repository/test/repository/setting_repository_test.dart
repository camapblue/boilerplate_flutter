import 'dart:ui';

import 'package:mockito/mockito.dart';
import 'package:repository/dao/dao.dart';

import 'package:repository/repository/impl/setting_repository_impl.dart';
import 'package:repository/repository/setting_repository.dart';
import 'package:test/test.dart';

class MockSettingDao extends Mock implements SettingDao {}

void main() {
  SettingDao settingDao = MockSettingDao();
  SettingRepository settingRepository;
  final _supportedLanguages = 'vi,en,zh';

  setUp(() {
    settingRepository =
        SettingRepositoryImpl(settingDao: settingDao, supportedLanguges: _supportedLanguages);
  });

  group('getCurrentLocale()', () {
    test('return Locale instance in case get language code from SettingDao', () async {
      final locale = Locale('vi');
      when(settingDao.getCurrentLocaleLanguageCode()).thenReturn('vi');

      expect(settingRepository.getCurrentLocale(), locale);
    });
  });

  group('getSupportedLocales()', () {
    test('return list of Locales in case get from ThemeDao', () {
      final supportedLocales = [Locale('vi'), Locale('en'), Locale('zh')];
      expect(settingRepository.getSupportedLocales(), supportedLocales);
    });
  });

}
