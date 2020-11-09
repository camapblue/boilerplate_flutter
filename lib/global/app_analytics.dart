import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AppAnalytics {
  static final AppAnalytics _singleton = AppAnalytics._internal();

  factory AppAnalytics() {
    return _singleton;
  }

  AppAnalytics._internal();

  final FirebaseAnalytics _fbAnalytics = FirebaseAnalytics();

  void logEvent({
    @required String name,
    Map<String, dynamic> parameters,
  }) {
    _fbAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  void logLogIn({
    @required String accountType,
    @required String deviceType,
  }) {
    _fbAnalytics
      ..logEvent(
        name: 'log_in',
        parameters: {
          'account_type': accountType,
          'device_type': deviceType,
        },
      );
  }

  void setCurrentScreen(String screenName) {
    if (screenName == null) {
      return;
    }
    _fbAnalytics.setCurrentScreen(screenName: screenName);
  }
}
