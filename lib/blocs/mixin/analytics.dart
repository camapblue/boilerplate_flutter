import 'package:boilerplate_flutter/global/app_analytics.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:repository/repository.dart';

mixin Analytics {
  void logLogIn({
    User loggedInUser,
    Authorization authorization,
  }) {
    final deviceType = Device.getDeviceType() == 1 ? 'android' : 'ios';
    AppAnalytics().logLogIn(
      accountType: authorization.accountType.toText(),
      deviceType: deviceType,
    );
  }
}
