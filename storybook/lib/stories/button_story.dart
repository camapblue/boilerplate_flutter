import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore_for_file: avoid_print
// ignore: must_be_immutable
class ButtonStory extends Story {
  ButtonStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent() {
    const sizedBoxSpace = SizedBox(height: 20);
    return [
      WidgetMap(
        title: 'Button',
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: Colors.black12,
          alignment: Alignment.center,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                XButton.primary(
                  title: 'Primary - Outline',
                  style: XButtonStyle.outline,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                XButton.primary(
                  title: 'Primary - Solid',
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                XButton.primary(
                  title: 'Primary - Text',
                  style: XButtonStyle.text,
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                const XButton.primary(
                  title: 'Primary - Disabled',
                ),
                sizedBoxSpace,
                XButton.negative(
                  title: 'Negative - Outline',
                  style: XButtonStyle.outline,
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                XButton.negative(
                  title: 'Negative - Solid',
                  style: XButtonStyle.solid,
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                XButton.negative(
                  title: 'Negative - Text',
                  style: XButtonStyle.text,
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                XButton(
                  title: 'Custom - Icon',
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: const [
                        Spacer(),
                        Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.white,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  onPressed: () => debugPrint('>>>>> Pressed'),
                ),
                sizedBoxSpace,
                const Spacer(),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
