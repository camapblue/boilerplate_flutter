import 'package:repository/repository.dart';

class SocialAccount extends Entity {
  final String socialId;
  final String token;
  final AccountType type;

  //ignore: prefer_constructors_over_static_methods
  static SocialAccount fromJson(Map<String, dynamic> json) {
    return SocialAccount(
      socialId: json['socialId'],
      token: json['token'],
      type: accountTypeFromKey(
        key: json['type'],
      ),
    );
  }

  SocialAccount({this.socialId, this.token, this.type});

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '\nSocial ID: $socialId \nToken: $token \nType: $type';
  }

  @override
  Map<String, dynamic> toJson() =>
      {'socialId': socialId, 'token': token, 'type': type.toValue()};
}
