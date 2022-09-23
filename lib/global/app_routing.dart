import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/modules/landing/landing_screen.dart';
import 'package:flutter/material.dart';

class AppRouting {
  final NavigatorState navigator;

  AppRouting({required this.navigator});

  void navigateTo(Deeplink deeplink) {
    switch (deeplink.screen) {
      case Screen.example:
        navigator.push(
            MaterialPageRoute(builder: (context) => const LandingScreen()));
        break;
      default:
        break;
    }
  }
}
