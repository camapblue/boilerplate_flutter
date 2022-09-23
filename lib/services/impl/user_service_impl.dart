import 'package:boilerplate_flutter/services/services.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:repository/repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({
    required UserRepository userRepository,
  })  : _userRepository = userRepository;

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    final user = User(userId: '', name: '', gender: Gender.male);

    final authorization = Authorization(
      accessToken: 'access_token'
    );
    Repository().authorization = authorization;

    await _userRepository.saveUser(user, authorization: authorization);

    return user;
  }

  @override
  Future<void> signOut() async {
    final deviceToken = _userRepository.getRegisteredDeviceToken();
    await _userRepository.signOut(deviceToken: deviceToken);

    Repository().authorization = _userRepository.getLoggedInAuthorization();

    // remove all cached data
    await _userRepository.clearAuthentication();
  }

  @override
  Future<void> registerDeviceIfNeeded({
    required String deviceToken,
    String? deviceUdid,
    int? deviceType,
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
