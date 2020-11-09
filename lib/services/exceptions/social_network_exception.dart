class SocialNetworkCancelException implements Exception {}

class SocialNetworkErrorException implements Exception {
  final String message;

  SocialNetworkErrorException(this.message);
}

class SocialNetworkUnauthorizedException implements Exception {}

class SocialNetworkAppleSignInIsNotAvailableException implements Exception {}