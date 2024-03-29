// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const int _TransitionDuration = 150;
const bool _barrierDismissible = false;
const String _barrierLabel = '';
const String basePopupDrawerKey = 'base_popup_drawer_widget_key';

Color _defaultBarrierColor = Colors.black.withAlpha(40);

class BasePopupDrawer extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  const BasePopupDrawer({
    Key? key,
    required this.context,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => child;

  Future<T?> show<T>() async {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return build(context);
      },
      barrierDismissible: _barrierDismissible,
      barrierLabel: _barrierLabel,
      barrierColor: _defaultBarrierColor,
      transitionDuration: const Duration(milliseconds: _TransitionDuration),
    );
  }
}
