import 'package:repository/enum/account_type.dart';

class SocialProfile {
  final String socialId;
  final String socialToken;
  final String name;
  final String email;
  final DateTime birthday;
  final String locale;
  final String avatarURL;
  final AccountType type;

  SocialProfile({
    this.socialId,
    this.socialToken,
    this.name,
    this.email,
    this.birthday,
    this.locale,
    this.avatarURL,
    this.type,
  });

  @override
  String toString() {
    return '''\nSocialId: $socialId\n Name: $name \nEmail: $email \nBirthday: $birthday \nLocale: $locale''';
  }
}
