import 'package:flutter/foundation.dart';

enum AccountType { facebook, google, apple }

AccountType accountTypeFromKey({@required int key}) {
  if (key == 1) { 
    return AccountType.facebook;
  } else if (key == 2) {
    return AccountType.google;
  }

  return AccountType.apple;
}

extension AccountTypeExtension on AccountType {
  int toValue() {
    if (this == AccountType.facebook) {
      return 1;
    } else if (this == AccountType.google) {
      return 2;
    }
    return 3;
  }

  String toText() {
    if (this == AccountType.facebook) {
      return 'facebook';
    } else if (this == AccountType.google) {
      return 'google';
    }
    return 'apple';
  }
}