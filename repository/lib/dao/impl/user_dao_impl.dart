import 'package:flutter/material.dart';
import 'package:repository/dao/base_dao.dart';
import 'package:repository/dao/user_dao.dart';
import 'package:repository/model/mapper.dart';
import 'package:repository/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _CurrentUserKey = 'key_current_user';
const _CurrentAuthorizationKey = 'key_current_authorization';
const _RegisteredDeviceTokenKey = 'key_registered_device_token';

class UserDaoImpl extends BaseDao<User> implements UserDao {
  UserDaoImpl({@required SharedPreferences preferences})
      : super(mapper: Mapper<User>(parse: User.fromJson), prefs: preferences);

  @override
  Future<void> saveUser(User user) {
    return saveItem(user, _CurrentUserKey);
  }

  @override
  Future<void> saveAuthorization(Authorization authorization) async {
    await saveEntity<Authorization>(authorization, _CurrentAuthorizationKey);
  }

  @override
  User loadUser() {
    return getItem(_CurrentUserKey);
  }

  @override
  Authorization loadAuthorization() {
    final authorization = getEntity<Authorization>(_CurrentAuthorizationKey,
        mapper:
            Mapper<Authorization>(parse: Authorization.fromJson));
    if (authorization == null) {
      return null;
    }
    
    return authorization;
  }

  @override
  String getRegisteredDeviceToken() {
    return getString(_RegisteredDeviceTokenKey);
  }

  @override
  Future<void> saveRegisteredDeviceToken({String deviceToken}) {
    return saveString(deviceToken, _RegisteredDeviceTokenKey);
  }

  @override
  Future<void> clearAuthentication() async {
    await Future.wait([
      clearObjectOrEntity(_CurrentUserKey),
      clearObjectOrEntity(_CurrentAuthorizationKey)
    ]);
  }
}
