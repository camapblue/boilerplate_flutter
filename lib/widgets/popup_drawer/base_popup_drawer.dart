// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';

class BasePopupDrawer extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const BasePopupDrawer({
    super.key,
    required this.context,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;

  Future<T?> show<T>({bool barrierDismissible = false}) async {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: build(context),
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible ? '' : null,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }
}
