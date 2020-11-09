import 'package:boilerplate_flutter/services/services.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:repository/model/user.dart';
import 'package:repository/repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final SocialNetworkConnect _socialNetworkConnect;

  UserServiceImpl({
    @required UserRepository userRepository,
    @required SocialNetworkConnect socialNetworkConnect,
  })  : _userRepository = userRepository,
        _socialNetworkConnect = socialNetworkConnect;

  @override
  Future<User> logIn({
    String socialId,
    String socialToken,
    AccountType accountType,
  }) async {
    final user = await _userRepository.logIn(
      socialId: socialId,
      socialToken: socialToken,
      accountType: accountType.toValue(),
    );

    final authorization = Authorization(
      userId: user.userId,
      socialId: socialId,
      socialToken: socialToken,
      accountType: accountType,
    );
    Repository().authorization = authorization;

    await _userRepository.saveUser(user, authorization: authorization);

    return user;
  }

  @override
  Future<void> signOut() async {
    final deviceToken = _userRepository.getRegisteredDeviceToken();
    await _userRepository.signOut(deviceToken: deviceToken);

    final authorization = _userRepository.getLoggedInAuthorization();
    await _socialNetworkConnect.signOut(type: authorization.accountType);

    Repository().authorization = null;

    // remove all cached data
    await _userRepository.clearAuthentication();
  }

  @override
  Future<void> registerDeviceIfNeeded({
    @required String deviceToken,
    String deviceUdid,
    int deviceType,
  }) async {
    final registeredDeviceToken = _userRepository.getRegisteredDeviceToken();

    if (registeredDeviceToken == deviceToken) {
      return;
    }

    final udid = deviceUdid ?? await Device.getUdid();
    return _userRepository.registerDevice(
        deviceToken: deviceToken,
        deviceType: deviceType ?? Device.getDeviceType(),
        deviceUdid: udid);
  }

  @override
  bool isUserAlreadyLoggedIn() {
    return _userRepository.getLoggedInUser() != null;
  }
}
