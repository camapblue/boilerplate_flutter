import 'package:flutter/foundation.dart';
import 'package:repository/client/base_client.dart';
import 'package:repository/client/client.dart';
import 'package:repository/model/authorization.dart';
import 'package:repository/model/user.dart';

class UserClientImpl extends BaseClient implements UserClient {
  UserClientImpl({@required String host, Authorization authorization})
      : super(host, authorization: authorization);

  @override
  Future<User> logIn(
      {String socialId, String socialToken, int accountType}) async {
    final data = {
      'socialId': socialId,
      'socialToken': socialToken,
      'accountType': accountType
    };

    final json = await post('/user/logIn', data);
    return User.fromJson(json['user']);
  }

  @override
  Future<User> me() async {
    final json = await get('/user/me');
    return User.fromJson(json['user']);
  }

  @override
  Future<void> signOut({@required String deviceToken}) {
    final data = {'deviceToken': deviceToken ?? ''};

    return post('/user/logOut', data);
  }

  @override
  Future<bool> registerDevice(
      {String deviceToken, int deviceType, String deviceUdid}) async {
    final payload = {
      'deviceToken': deviceToken,
      'deviceType': deviceType,
      'deviceUdid': deviceUdid
    };

    final _ = await post('/user/registerDevice', payload);
    return true;
  }
}
