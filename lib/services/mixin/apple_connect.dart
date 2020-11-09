import 'package:boilerplate_flutter/services/exceptions/social_network_exception.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:common/common.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:repository/enum/account_type.dart';

mixin AppleConnect {
  AppleIdCredential _credential;

  Future<AppleIdCredential> appleSignIn() async {
    if (await AppleSignIn.isAvailable()) {
      final result = await AppleSignIn.performRequests([
        const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          {
            _credential = result.credential;
            return result.credential; //All the required credentials
          }
          break;
        case AuthorizationStatus.error:
          {
            log.error('''Social Network Log In Error
                 >> ${result.error.localizedDescription}''');
            throw SocialNetworkErrorException(
                result.error.localizedDescription);
          }
          break;
        case AuthorizationStatus.cancelled:
          throw SocialNetworkCancelException();
          break;
      }
    }
    throw SocialNetworkAppleSignInIsNotAvailableException();
  }

  Future<SocialProfile> getAppleUserProfile() async {
    if (_credential == null) {
      await appleSignIn();
    }

    var name =
        '''${_credential.fullName.givenName} ${_credential.fullName.familyName}''';
    if (_credential.fullName.givenName == null ||
        _credential.fullName.familyName == null) {
      name = 'Anonymous';
    }

    return SocialProfile(
      socialId: _credential.user.replaceAll('.', ''),
      socialToken:
          String.fromCharCodes(_credential.identityToken).replaceAll('.', '_'),
      name: name,
      email: _credential.email ?? '',
      avatarURL: '',
      type: AccountType.apple,
    );
  }
}
