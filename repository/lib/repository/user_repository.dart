import 'package:flutter/foundation.dart';
import 'package:repository/model/model.dart';

abstract class UserRepository {
  Future<User> logIn({
    @required String socialId,
    @required String socialToken,
    @required int accountType,
  });

  Future<void> signOut({@required String deviceToken});

  Future<void> saveUser(User user, {Authorization authorization});

  Future<void> clearAuthentication();

  User getLoggedInUser();

  Future<User> getLatestLoggedInUser();

  Authorization getLoggedInAuthorization();

  String getRegisteredDeviceToken();

  Future<void> registerDevice({
    @required String deviceToken,
    @required int deviceType,
    @required String deviceUdid,
  });
}
