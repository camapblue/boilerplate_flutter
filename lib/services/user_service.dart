import 'package:flutter/foundation.dart';
import 'package:repository/repository.dart';

abstract class UserService {
  Future<User> logIn({
    @required String socialId,
    @required String socialToken,
    AccountType accountType,
  });

  Future<void> signOut();

  Future<void> registerDeviceIfNeeded({
    @required String deviceToken,
    String deviceUdid,
    int deviceType,
  });

  bool isUserAlreadyLoggedIn();
}
