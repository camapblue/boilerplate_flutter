// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class Strings {
  static _Common get Common => _Common();

  static _Button get Button => _Button();

  static _ShowMessage get ShowMessage => _ShowMessage();
}

// Common for some test really commonly that can be used in many apps
class _Common {
  final String appName = 'Boilerplate';
  // today, yesterday, tommorrow

  final String errorPopupTitle = 'common.error';

  final String you = 'common.you';

  final String connectingSocialAccount = 'common.connecting_social_account';
  final String loggingIn = 'common.logging_in';
  final String signingIn = 'common.signing_in';
  final String signingOut = 'common.signing_out';
  final String loading = 'common.loading';
  final String noInternetConnection = 'common.no_internet_connection';
  final String appleSignInIsNotAvailable =
      'common.apple_sign_in_is_not_available';

  final String languageEnglish = 'common.language.english';
  final String languageVietnamese = 'common.language.vietnamese';
  final String languageFrench = 'common.language.french';
}

class _Button {
  final String cancel = 'button.cancel';
  final String close = 'button.close';
  final String ignore = 'button.ignore';
  final String accept = 'button.accept';
  final String later = 'button.later';
  final String save = 'button.save';
  final String reload = 'button.reload';
  final String rate = 'button.rate';
  final String share = 'button.share';

  final String signInWithFacebook = 'button.sign_in_with_facebook';
  final String signInWithGoogle = 'button.sign_in_with_google';
  final String signInWithApple = 'button.sign_in_with_apple';

  final String signIn = 'Sign In !';
  final String signUp = 'button.sign_up';
  final String signingUp = 'button.signing_up';

  final String next = 'button.next';
  final String skip = 'button.skip';
  final String done = 'button.done';

  final String tryAsGuest = 'button.try_as_guest';
}

class _ShowMessage {
  final String settingUpdated = 'show_message.setting_updated';
}
