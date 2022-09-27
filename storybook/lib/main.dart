import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'stories/stories.dart';
import 'storybook.dart';

void main() {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: DefaultTheme().build(context),
          localizationsDelegates: const [
            SLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('vi'), // Vietnamese
          ],
          locale: const Locale('vi'),
          home: Storybook(
            [
              BounceStory(), // Common
              BounceButtonStory(),
              LoadListStory(),
              ButtonStory(),
              MenuBarStory(),
              TextStory(),
              ValidatorInputStory(),
            ],
          ),
        );
      },
    ),
  );
}
