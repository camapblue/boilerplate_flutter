import 'package:repository/client/client.dart';
import 'package:repository/model/authorization.dart';
import 'package:repository/model/user.dart';

class UserClientImpl extends BaseClient implements UserClient {
  UserClientImpl({
    required String host,
    Authorization? authorization,
  }) : super(host, authorization: authorization);

  @override
  Future<User> getProfile() async {
    final json = await get('/user/profile');
    return User.fromJson(json['user']);
  }

  @override
  Future<void> signOut({String? deviceToken}) {
    final data = {'deviceToken': deviceToken ?? ''};

    return post('/user/logOut', data);
  }

  @override
  Future<bool> registerDevice({
    required String deviceToken,
    required int deviceType,
    required String deviceUdid,
  }) async {
    final payload = {
      'deviceToken': deviceToken,
      'deviceType': deviceType,
      'deviceUdid': deviceUdid
    };

    final _ = await post('/user/registerDevice', payload);
    return true;
  }
}
