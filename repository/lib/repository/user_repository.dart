import 'package:repository/model/model.dart';

abstract class UserRepository {
  Future<void> signOut({String? deviceToken});

  Future<void> saveUser(User user, {Authorization? authorization});

  Future<void> clearAuthentication();

  User? getLoggedInUser();

  Future<User> getLatestLoggedInUser();

  Authorization? getLoggedInAuthorization();

  String? getRegisteredDeviceToken();

  Future<void> registerDevice({
    required String deviceToken,
    required int deviceType,
    required String deviceUdid,
  });
}
