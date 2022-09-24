import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AppRouting {
  static final AppRouting _singleton = AppRouting._internal();

  factory AppRouting() {
    return _singleton;
  }

  AppRouting._internal();

  final _scaffoldMessengerStateKey = GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerState =>
      _scaffoldMessengerStateKey;

  BuildContext? get context => _scaffoldMessengerStateKey.currentContext;

  void navigateTo(Deeplink deeplink) {
    switch (deeplink.screen) {
      case Screen.example:
        QR.to(Screens.landing);
        break;
      default:
        break;
    }
  }

  void pushNamed(String routeName, {Map<String, dynamic>? params}) {
    QR.toName(routeName, params: params);
  }

  void pushReplacementNamed(String routeName, {Map<String, dynamic>? params}) {
    QR.navigator.replaceAllWithName(routeName, params: params);
  }
}
