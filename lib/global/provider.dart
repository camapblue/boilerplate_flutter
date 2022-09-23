import 'package:boilerplate_flutter/services/services.dart';
import 'package:package_info/package_info.dart';
import 'package:repository/repository.dart';

class Provider {
  static final Provider _singleton = Provider._internal();

  factory Provider() {
    return _singleton;
  }

  Provider._internal();

  bool isPhysicalDevice = true;
  late PackageInfo packageInfo;

  // Service
  UserService get userService => UserServiceImpl(
        userRepository: Repository().userRepository,
      );

  SessionService get sessionService =>
      SessionServiceImpl(userRepository: Repository().userRepository);

  SettingService get settingService =>
      SettingServiceImpl(settingRepository: Repository().settingRepository);
}
