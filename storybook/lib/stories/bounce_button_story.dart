import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import '../storybook.dart';

// ignore: must_be_immutable
class BounceButtonStory extends Story {
  BounceButtonStory({super.key});

  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Common | Bounce Button',
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
                  child: BounceButton(
                    title: 'Touch Here',
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      debugPrint('Touched');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BounceButton(
                    title: 'Touch Here',
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      debugPrint('Touched');
                    },
                    isLoading: true,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BounceButton(
                    title: 'Touch Here',
                    color: AppColors.negative,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      debugPrint('Touched');
                    },
                    isLoading: true,
                    loadingText: 'Processing',
                    loadingTextStyle: context.bodyMedium,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BounceButton(
                    icon: const AppIcon(
                      icon: AppIcons.bell,
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    title: 'Align Left',
                    alignment: Alignment.centerLeft,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () {
                      debugPrint('Touched');
                    },
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
