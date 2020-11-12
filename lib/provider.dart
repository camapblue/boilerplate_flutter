import 'package:repository/repository.dart';

import 'services/services.dart';

class Provider {
  static final Provider _singleton = Provider._internal();

  factory Provider() {
    return _singleton;
  }

  Provider._internal();

  // Service
  UserService get userService => UserServiceImpl(
        userRepository: Repository().userRepository,
        socialNetworkConnect: Provider().socialNetworkConnect,
      );

  SocialNetworkConnect get socialNetworkConnect => SocialNetworkConnectImpl();

  SettingService get settingService =>
      SettingServiceImpl(settingRepository: Repository().settingRepository);

  SessionService get sessionService =>
      SessionServiceImpl(userRepository: Repository().userRepository);
}
