import 'package:boilerplate_flutter/services/mixin/mixin.dart';
import 'package:boilerplate_flutter/models/social_profile.dart';
import 'package:boilerplate_flutter/services/social_network_connect.dart';
import 'package:repository/enum/account_type.dart';
import 'package:repository/model/social_account.dart';

class SocialNetworkConnectImpl
    with GoogleConnect
    implements SocialNetworkConnect {
  @override
  Future<SocialProfile> getUserProfile({SocialAccount socialAccount}) async {
    return getGoogleUserProfile();
  }

  @override
  Future<SocialAccount> logIn({AccountType type}) async {
    try {
      final googleAccount = await googleLogIn();
        final authentication = await googleAccount.authentication;

        return SocialAccount(
          socialId: googleAccount.id,
          token: authentication.accessToken,
          type: type,
        );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut({AccountType type}) {
    return googleSignOut();
  }
}
