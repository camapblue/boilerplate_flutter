import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/global/global.dart';

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
              LoadListStory()
            ],
          ),
        );
      },
    ),
  );
}
