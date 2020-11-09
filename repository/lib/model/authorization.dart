import 'package:flutter/foundation.dart';
import 'package:repository/model/model.dart';
import 'package:repository/enum/enum.dart';

class Authorization extends Entity {
  final String userId;
  final String socialId;
  final String socialToken;
  final AccountType accountType;

  Authorization({
    @required this.userId,
    @required this.socialId,
    @required this.socialToken,
    @required this.accountType,
  });

  //ignore: prefer_constructors_over_static_methods
  static Authorization fromJson(Map<String, dynamic> json) {
    return Authorization(
      userId: json['user_id'],
      socialId: json['social_id'],
      socialToken: json['social_token'],
      accountType: accountTypeFromKey(key: json['account_type']),
    );
  }

  @override
  List<Object> get props => null;

  @override
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'socialId': socialId,
    'socialToken': socialToken,
    'account_type': accountType.toValue()
  };
}
