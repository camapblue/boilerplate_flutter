import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore_for_file: avoid_print
// ignore: must_be_immutable
class TextStory extends Story {
  TextStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent() {
    const smallBoxSpace = SizedBox(height: 8);
    return [
      WidgetMap(
        title: 'Text',
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: Colors.black12,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Spacer(),
                XText.displayLarge('Display Large'),
                smallBoxSpace,
                XText.displayMedium('Display Medium'),
                smallBoxSpace,
                XText.displaySmall('Display Small'),
                SizedBox(height: 24),
                XText.headlineLarge('Headline Large'),
                smallBoxSpace,
                XText.headlineMedium('Headline Medium'),
                smallBoxSpace,
                XText.headlineSmall('Headline Small'),
                SizedBox(height: 24),
                XText.titleLarge('Title Large'),
                smallBoxSpace,
                XText.titleMedium('Title Medium'),
                smallBoxSpace,
                XText.titleSmall('Title Small'),
                SizedBox(height: 24),
                XText.bodyLarge('Body Large'),
                smallBoxSpace,
                XText.bodyMedium('Body Medium'),
                smallBoxSpace,
                XText.bodySmall('Body Small'),
                Spacer(),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
