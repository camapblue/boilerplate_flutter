import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final AppAnalytics _singleton = AppAnalytics._internal();

  factory AppAnalytics() {
    return _singleton;
  }

  AppAnalytics._internal();

  final FirebaseAnalytics _fbAnalytics = FirebaseAnalytics.instance;

  void logEvent({
    required String name,
    Map<String, dynamic> parameters = const {},
  }) {
    _fbAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  void logLogIn({
    required String name,
    required String deviceType,
  }) {
    _fbAnalytics
      .logEvent(
        name: 'log_in',
        parameters: {
          'name': name,
          'device_type': deviceType,
        },
      );
  }

  void setCurrentScreen({String? screenName}) {
    if (screenName == null) {
      return;
    }
    _fbAnalytics.setCurrentScreen(screenName: screenName);
  }
}
