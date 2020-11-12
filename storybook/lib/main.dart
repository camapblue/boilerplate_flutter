import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:boilerplate_flutter/blocs/base/simple_bloc_delegate.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/modules/theme/load_theme.dart';

import 'stories/stories.dart';
import 'storybook.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: loadTheme(),
          localizationsDelegates: const [
            SLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('vi'), // Bahasa
          ],
          locale: const Locale('vi'),
          home: Storybook(
            [
              BounceStory(), // Common
              BounceButtonStory(),
            ],
          ),
        );
      },
    ),
  );
}
