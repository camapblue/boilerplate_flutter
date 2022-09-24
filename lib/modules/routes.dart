// ignore_for_file: unnecessary_lambdas

import 'package:boilerplate_flutter/constants/screens.dart';
import 'package:common/core/core.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'landing/landing_screen.dart' deferred as landing;
import 'splash/splash_screen.dart';
import 'log_in/log_in_screen.dart' deferred as log_in;

class AppRouter {
  static void initialize() {
    QR.settings.pagesType = const QMaterialPage();

    QR.setUrlStrategy();
  }

  static List<QRoute> allRoutes() {
    return <QRoute>[
      QRoute(
        path: Screens.splash,
        name: Screens.splash,
        builder: () => const SplashScreen(),
      ),
      QRoute(
        path: Screens.landing,
        name: Screens.landing,
        builder: () => landing.LandingScreen(),
        middleware: [
          DeferredLoader(landing.loadLibrary),
        ],
      ),
      QRoute(
        path: Screens.logIn,
        name: Screens.logIn,
        builder: () => log_in.LogInScreen(),
        middleware: [
          DeferredLoader(log_in.loadLibrary),
        ],
      ),
    ];
  }
}
