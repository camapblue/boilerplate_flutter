import 'dart:convert';
import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import 'package:boilerplate_flutter/services/exceptions/social_network_exception.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:repository/enum/enum.dart';

const _permissions = [
  'public_profile',
  'email',
  'user_birthday',
  'user_friends'
];
const _profileFields = 'name,email,birthday,locale';
const _graphAPIURL = 'https://graph.facebook.com/v6.0';

mixin FacebookConnect {
  Future<FacebookAccessToken> facebookLogIn() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(_permissions);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result.accessToken;
      case FacebookLoginStatus.cancelledByUser:
        await _forceLogOutIfNeeded();
        throw SocialNetworkCancelException();
      case FacebookLoginStatus.error:
        {
          log.error('Social Network Log In Error >> ${result.errorMessage}');
          await _forceLogOutIfNeeded();
          throw SocialNetworkErrorException(result.errorMessage);
        }
    }

    throw Exception();
  }

  Future<void> facebookLogOut() {
    return FacebookLogin().logOut();
  }

  Future<void> _forceLogOutIfNeeded() async {
    final facebookLogin = FacebookLogin();
    if (await facebookLogin.isLoggedIn) {
      await facebookLogin.logOut();
    }
  }

  Future<SocialProfile> getFacebookUserProfile({@required String token}) async {
    final graphResponse = await http
        .get('$_graphAPIURL/me?fields=$_profileFields&access_token=$token');
    final json = jsonDecode(graphResponse.body);

    return SocialProfile(
      socialId: json['id'],
      socialToken: token,
      name: json['name'],
      email: json['email'],
      birthday: ifNotNullThen<String, DateTime>(
          json['birthday'], DateTimeExtension.parseFacebookDateTimeString),
      locale: json['locale'] ?? 'en',
      type: AccountType.facebook,
      avatarURL: _buildFacebookAvatarUrl(json['id']),
    );
  }

  String _buildFacebookAvatarUrl(String facebookId) {
    return 'https://graph.facebook.com/$facebookId/picture?type=large';
  }

  Future<List<String>> getFacebookFriendIds(
      {@required String token, @required String userId}) async {
    final graphUrl = '$_graphAPIURL/$userId/friends?access_token=$token';
    final graphResponse = await http.get(graphUrl);

    final json = jsonDecode(graphResponse.body);
    if (json['error'] != null) {
      return <String>[];
    }
    final List<dynamic> data = json['data'];

    return data.map((d) => d['id'].toString()).toList();
  }
}
