// ignore_for_file: constant_identifier_names

import 'package:boilerplate_flutter/constants/app_colors.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:common/animated/animated.dart';

class Alert extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String message;
  final String? okTitle;

  const Alert({
    super.key,
    this.icon,
    this.title = '',
    required this.message,
    this.okTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBounce(
        child: AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              icon 
                ?? XText.headlineMedium(title)
                .customWith(context, color: AppColors.negative),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 24,
                ),
                child: XSpanLabel(
                  text: message,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.all(8),
          content: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Spacer(),
                SizedBox(
                  height: 40,
                  child: XButton.outlined(
                    title: okTitle ?? 'Close',
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    color: AppColors.negative,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
