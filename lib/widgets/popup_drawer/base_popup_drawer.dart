import 'package:flutter/material.dart';

const int _TransitionDuration = 150;
const bool _barrierDismissible = false;
const String _barrierLabel = '';
const String basePopupDrawerKey = 'base_popup_drawer_widget_key';

Color _defaultBarrierColor = Colors.black.withAlpha(40);

class BasePopupDrawer extends StatelessWidget {
  final BuildContext context;
  final Widget child;

  BasePopupDrawer({
    Key key,
    @required this.context,
    @required this.child,
  })  : assert(
          context != null,
          '$runtimeType context can not null!',
        ),
        assert(
          child != null,
          '$runtimeType child can not null!',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) => child;

  Future<T> show<T>() async {
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
