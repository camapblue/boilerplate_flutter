import 'package:repository/model/model.dart';

abstract class UserClient {
  Future<User> getProfile();

  Future<void> signOut({String? deviceToken});

  Future<bool> registerDevice({
    required String deviceToken,
    required int deviceType,
    required String deviceUdid,
  });
}
