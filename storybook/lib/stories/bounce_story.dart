import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../storybook.dart';

// ignore: must_be_immutable
class BounceStory extends Story {
  BounceStory({super.key});

  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Common | Bounce',
        builder: (context) => Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Bounce(
                    onPressed: () {
                      debugPrint('Card Touched');
                    },
                    child: const Card(
                      child: Center(child: Text('Card here'),),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      )
    ];
  }
}
