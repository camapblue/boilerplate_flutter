import 'package:boilerplate_flutter/blocs/deeplink/deeplink.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/modules/landing/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final NavigatorState navigator;

  AppRouter({this.navigator});

  void navigateTo(Deeplink deeplink) {
    switch (deeplink.screen) {
      case Screen.example:
        navigator
            .push(MaterialPageRoute(builder: (context) => LandingScreen()));
        break;
      default:
        break;
    }
  }
}
