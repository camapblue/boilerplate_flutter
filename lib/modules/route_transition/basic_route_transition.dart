import 'package:flutter/material.dart';

class BasicRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration duration;

  BasicRouteTransition({
    @required this.pageBuilder,
    @required String routeName,
    Object arguments,
    this.duration = const Duration(
      milliseconds: 350,
    ),
  })  : assert(pageBuilder != null, 'Must provide page builder!'),
        super(settings: RouteSettings(name: routeName, arguments: arguments));

  @override
  Color get barrierColor => Colors.black.withAlpha(1);

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;
}
