import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/modules/log_in/log_in_screen.dart';
import 'package:boilerplate_flutter/modules/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> allRoutes(BuildContext context) {
    return {
      Screens.splash: (context) => SplashScreen(),
      Screens.logIn: (context) => LogInScreen()
    };
  }
}
