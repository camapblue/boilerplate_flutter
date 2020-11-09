import 'package:boilerplate_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'fade_route_transition.dart';
import 'basic_route_transition.dart';

extension NavigatorExtension on NavigatorState {
  Future<void> pushFadeTransition(
      {@required String routeName, Object arguments, Duration duration}) {
    return push(
      FadeRouteTransition(
        pageBuilder: Routes.allRoutes(context)[routeName],
        routeName: routeName,
        arguments: arguments,
        duration: duration,
      ),
    );
  }

  Future<void> pushReplacementFadeTransition(
      {@required String routeName, Object arguments, Duration duration}) {
    return pushReplacement(
      FadeRouteTransition(
        pageBuilder: Routes.allRoutes(context)[routeName],
        routeName: routeName,
        arguments: arguments,
        duration: duration,
      ),
    );
  }

  Future<void> pushWithNamed(
    String routeName, {
    Object arguments,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return push(
      BasicRouteTransition(
        pageBuilder: Routes.allRoutes(context)[routeName],
        routeName: routeName,
        arguments: arguments,
        duration: duration,
      ),
    );
  }
}
