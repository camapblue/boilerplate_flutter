import 'dart:ui';

import 'package:boilerplate_flutter/services/services.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/repository/setting_repository.dart';
import 'package:test/test.dart';

class MockSettingRepository extends Mock implements SettingRepository {}

void main() {
  late SettingService settingService;
  final SettingRepository settingRepository = MockSettingRepository();

  setUp(() {
    settingService = SettingServiceImpl(
      settingRepository: settingRepository,
    );
  });

  group('getCurrentLocale()', () {
    test('return instance of Locale in case get from theme repository', () {
      const locale = Locale('id');

      when(settingRepository.getCurrentLocale()).thenReturn(locale);

      expect(settingService.getCurrentLocale(), locale);
    });

    test('return list of instance of Locale in case get from theme repository',
        () {
      final supportedLocales = [const Locale('id'), const Locale('fr')];

      when(settingRepository.getSupportedLocales())
          .thenReturn(supportedLocales);

      expect(settingService.getSupportedLocales(), supportedLocales);
    });
  });
}
