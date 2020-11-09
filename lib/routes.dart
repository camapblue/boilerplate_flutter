import 'package:boilerplate_flutter/modules/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';

import 'modules/landing/landing_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> allRoutes(BuildContext context) {
    return {
      '/': (context) => LandingScreen(),
      '/logIn': (context) => LogInScreen()
    };
  }
}
