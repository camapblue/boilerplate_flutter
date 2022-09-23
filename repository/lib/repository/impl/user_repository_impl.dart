import 'package:repository/client/client.dart';
import 'package:repository/dao/dao.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository/repository.dart';
import 'package:repository/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserClient _userClient;
  final UserDao _userDao;

  UserRepositoryImpl({
    required UserClient userClient,
    required UserDao userDao,
  })  : _userClient = userClient,
        _userDao = userDao;

  @override
  Future<void> saveUser(User user, {Authorization? authorization}) async {
    await _userDao.saveUser(user);

    if (authorization != null) {
      await _userDao.saveAuthorization(authorization);
    }
  }

  @override
  User? getLoggedInUser({bool forceToUpdate = false}) {
    return _userDao.loadUser();
  }

  @override
  Future<User> getLatestLoggedInUser() async {
    final user = await _userClient.getProfile();
    await _userDao.saveUser(user);
    return user;
  }

  @override
  Authorization? getLoggedInAuthorization() {
    return _userDao.loadAuthorization();
  }

  @override
  Future<void> signOut({String? deviceToken}) async {
    await _userClient.signOut(deviceToken: deviceToken);
  }

  @override
  Future<void> clearAuthentication() {
    return _userDao.clearAuthentication();
  }

  @override
  String? getRegisteredDeviceToken() {
    return _userDao.getRegisteredDeviceToken();
  }

  @override
  Future<void> registerDevice({
    required String deviceToken,
    required int deviceType,
    required String deviceUdid,
  }) async {
    final result = await _userClient.registerDevice(
      deviceToken: deviceToken,
      deviceType: deviceType,
      deviceUdid: deviceUdid,
    );

    if (result) {
      await _userDao.saveRegisteredDeviceToken(deviceToken: deviceToken);
    }
  }
}
