import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/extension/color_extension.dart';
import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class MenuBarStory extends Story {
  final List<String> data = [
    'Bean',
    'Beverage',
    'Meat',
    'Vegetable',
    'Noodle',
    'Baby',
    'Clothes',
    'Jewelry'
  ];

  MenuBarStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Menu Bar - Text',
        builder: (context) {
          var pageIndex = 0;
          var pageTitle = data[pageIndex];
          Function renderFunction = () {};
          final menuController = MenuBarController();

          return Container(
            color: Colors.white70,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MenuBar(
                  menuController: menuController,
                  backgroundColor: context.primaryColor,
                  totalItem: data.length,
                  itemBuilder: (index, selected) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Text(
                      data[index],
                      style: selected
                          ? context.displayMedium?.copyWith(
                                color: Colors.black87,
                                fontSize: 19,
                              )
                          : context.displayMedium?.copyWith(
                                color: Colors.grey,
                                fontSize: 19,
                              ),
                    ),
                  ),
                  onItemChanged: (int itemIndex) {
                    pageIndex = itemIndex;
                    pageTitle = data[itemIndex];

                    renderFunction();
                  },
                ),
                Expanded(
                  child: StatefulStory(
                    builder: () => Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Text(
                        '''Page ${pageIndex + 1} - $pageTitle''',
                        style: TextStyle(
                          color: ColorExtension.randomColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    renderFunction: (render) {
                      renderFunction = render;
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    ];
  }
}
