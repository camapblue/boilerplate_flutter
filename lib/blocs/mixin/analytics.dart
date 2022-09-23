import 'package:boilerplate_flutter/global/app_analytics.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:repository/repository.dart';

mixin Analytics {
  void logLogIn({
    required User loggedInUser,
    Authorization? authorization,
  }) {
    final deviceType = Device.getDeviceType() == 1 ? 'android' : 'ios';
    AppAnalytics().logLogIn(
      name: loggedInUser.name,
      deviceType: deviceType,
    );
  }
}
