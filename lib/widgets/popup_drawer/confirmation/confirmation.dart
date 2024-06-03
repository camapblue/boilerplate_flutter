// ignore_for_file: constant_identifier_names

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:common/animated/animated.dart';

class Confirmation extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String message;
  final String? okTitle;
  final String? cancelTitle;

  const Confirmation({
    super.key,
    this.icon,
    this.title = '',
    required this.message,
    this.okTitle,
    this.cancelTitle,
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
              icon ??
                  XText.headlineMedium(title)
                      .customWith(context, color: AppColors.neutral),
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
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: XButton.outlined(
                      color: AppColors.warningDark,
                      title: cancelTitle ?? 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: XButton.primary(
                      color: AppColors.neutral,
                      title: okTitle ?? 'Yes',
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ),
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
