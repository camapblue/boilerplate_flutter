import 'package:flutter/material.dart';

import 'stories/stories.dart';
import 'storybook.dart';

void main() {
  runApp(
    Builder(
      builder: (BuildContext context) {
        return MaterialApp(
          theme: ThemeData(),
          home: Storybook(
            [
              BounceStory(),
              BounceButtonStory(),
            ],
          ),
        );
      },
    ),
  );
}
