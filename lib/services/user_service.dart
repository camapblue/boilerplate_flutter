import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> logIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> registerDeviceIfNeeded({
    required String deviceToken,
    String? deviceUdid,
    int? deviceType,
  });

  bool isUserAlreadyLoggedIn();
}
