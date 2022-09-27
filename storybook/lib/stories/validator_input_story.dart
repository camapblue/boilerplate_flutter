import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '../storybook.dart';

// ignore: must_be_immutable
class ValidatorInputStory extends Story {
  ValidatorInputStory({super.key});

  @override
  List<WidgetMap> storyContent() {
    return [
      WidgetMap(
        title: 'Common | Validator Input',
        builder: (context) => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                ValidatorInput(
                  title: 'Name',
                  placeholder: 'Please enter name',
                  initialValue: 'Walter',
                  onFieldSubmitted: print,
                  validatorRules: [
                    InputValidatorRule.require(
                      errorMessage: 'Please enter the name',
                    )
                  ],
                ),
                const SizedBox(height: 12),
                ValidatorInput(
                  title: 'Email',
                  placeholder: 'name@example.com',
                  onFieldSubmitted: print,
                  validatorRules: [
                    InputValidatorRule.require(
                      errorMessage: 'Please enter email',
                    ),
                    InputValidatorRule(
                      errorMessage: 'Invalid email',
                      validator: (input) => input != null && input.isEmail(),
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      )
    ];
  }
}
