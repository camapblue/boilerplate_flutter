import 'package:flutter/foundation.dart';
import 'package:repository/model/model.dart';

abstract class UserClient {
  Future<User> logIn({
    @required String socialId,
    @required String socialToken,
    @required int accountType,
  });

  Future<User> me();

  Future<void> signOut({@required String deviceToken});

  Future<bool> registerDevice({
    @required String deviceToken,
    @required int deviceType,
    @required String deviceUdid,
  });
}
