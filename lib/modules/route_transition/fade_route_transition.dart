import 'package:flutter/material.dart';

class FadeRouteTransition<T> extends PageRoute<T> {
  final WidgetBuilder pageBuilder;
  final Duration duration;

  FadeRouteTransition({
    @required this.pageBuilder,
    @required String routeName,
    Object arguments,
    this.duration,
  }) : assert(pageBuilder != null, 'Must provide page builder!'),
    super(settings: RouteSettings(name: routeName, arguments: arguments));

  @override
  Color get barrierColor => Colors.black.withAlpha(1);

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration ?? const Duration(
    milliseconds: 1000,
  );

  @override
  bool get opaque => false;
}