import 'dart:ui';

import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/services/setting_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'language_bloc_test.mocks.dart';

@GenerateMocks([SettingService])
void main() {
  late LanguageBloc languageBloc;
  final SettingService settingService = MockSettingService();

  const currentLocale = Locale('id');
  const supportedLocales = [Locale('id'), Locale('en')];

  setUp(() {
    when(settingService.getCurrentLocale()).thenReturn(currentLocale);
    when(settingService.getSupportedLocales()).thenReturn(supportedLocales);

    languageBloc = LanguageBloc(const Key('language_bloc'),
        settingService: settingService);
  });

  test.tearDownAll(() {
    languageBloc.close();
  });

  group('LanguageInitial', () {
    test.test('LanguageInitial is set current locale & supported locales', () {
      const state = LanguageInitial(Locale('id'), [Locale('id'), Locale('en')]);

      expect(languageBloc.state, state);
    });
  });

  group('LanguageLoaded', () {
    blocTest(
      '''
        emits [LanguageInitial, LanguageUpdateSuccess] when LanguageUpdated(en) is added
      ''',
      build: () => languageBloc,
      act: (LanguageBloc? bloc) =>
          bloc?.add(const LanguageUpdated(Locale('en'))),
      expect: () => [isA<LanguageUpdateSuccess>()],
    );
  });
}
