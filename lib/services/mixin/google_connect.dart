import 'package:boilerplate_flutter/services/exceptions/social_network_exception.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:common/common.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:repository/enum/account_type.dart';

mixin GoogleConnect {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
    hostedDomain: '',
    clientId: '',
  );

  Future<GoogleSignInAccount> googleLogIn() async {
    final isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      final _ = await _googleSignIn.signInSilently();
      return _googleSignIn.currentUser;
    }

    try {
      await _googleSignIn.signIn();

      return _googleSignIn.currentUser;
    } catch (e) {
      log.error('Google Sign In Error >> $e');
      throw SocialNetworkErrorException(e.toString());
    }
  }

  Future<void> googleSignOut() async {
    return _googleSignIn.signOut();
  }

  Future<SocialProfile> getGoogleUserProfile() async {
    final isSignedIn = await _googleSignIn.isSignedIn();
    if (!isSignedIn && _googleSignIn.currentUser == null) {
      throw SocialNetworkUnauthorizedException();
    }

    if (_googleSignIn.currentUser == null) {
      final _ = await _googleSignIn.signInSilently();
    }
    final currentUser = _googleSignIn.currentUser;
    final authentication = await currentUser.authentication;

    return SocialProfile(
        socialId: currentUser.id,
        socialToken: authentication.accessToken,
        name: currentUser.displayName,
        email: currentUser.email,
        avatarURL: currentUser.photoUrl,
        type: AccountType.google);
  }
}
