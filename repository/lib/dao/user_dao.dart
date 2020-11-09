import 'package:flutter/foundation.dart';
import 'package:repository/model/model.dart';

abstract class UserDao {
  Future<void> saveUser(User user);

  Future<void> saveAuthorization(Authorization authorization);

  User loadUser();

  Authorization loadAuthorization();

  Future<void> saveRegisteredDeviceToken({@required String deviceToken});

  String getRegisteredDeviceToken();

  Future<void> clearAuthentication();
}
