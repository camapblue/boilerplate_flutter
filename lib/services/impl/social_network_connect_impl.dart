import 'package:boilerplate_flutter/services/mixin/mixin.dart';
import 'package:boilerplate_flutter/models/social_profile.dart';
import 'package:boilerplate_flutter/services/social_network_connect.dart';
import 'package:repository/enum/account_type.dart';
import 'package:repository/model/social_account.dart';

class SocialNetworkConnectImpl
    with FacebookConnect, GoogleConnect, AppleConnect
    implements SocialNetworkConnect {
  @override
  Future<List<String>> getSocialFriendIds({SocialAccount socialAccount}) {
    if (socialAccount.type == AccountType.facebook) {
      return getFacebookFriendIds(
          token: socialAccount.token, userId: socialAccount.socialId);
    }
    return Future.value(null);
  }

  @override
  Future<SocialProfile> getUserProfile({SocialAccount socialAccount}) async {
    if (socialAccount.type == AccountType.facebook) {
      return getFacebookUserProfile(token: socialAccount.token);
    } else if (socialAccount.type == AccountType.google) {
      return getGoogleUserProfile();
    }
    return getAppleUserProfile();
  }

  @override
  Future<SocialAccount> logIn({AccountType type}) async {
    try {
      if (type == AccountType.facebook) {
        final facebookAccount = await facebookLogIn();
        return SocialAccount(
            socialId: facebookAccount.userId,
            token: facebookAccount.token,
            type: type);
      } else if (type == AccountType.google) {
        final googleAccount = await googleLogIn();
        final authentication = await googleAccount.authentication;

        return SocialAccount(
          socialId: googleAccount.id,
          token: authentication.accessToken,
          type: type,
        );
      }
      final appleUser = await appleSignIn();
      return SocialAccount(
        socialId: appleUser.user.replaceAll('.', ''),
        token:
            String.fromCharCodes(appleUser.identityToken).replaceAll('.', '_'),
        type: type,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut({AccountType type}) {
    if (type == AccountType.facebook) {
      return facebookLogOut();
    } else {
      return googleSignOut();
    }
  }
}
