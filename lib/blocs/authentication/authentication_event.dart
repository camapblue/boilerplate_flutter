import 'package:flutter/foundation.dart';
import 'package:repository/enum/account_type.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final AccountType type;

  const AuthenticationLoggedIn({@required this.type});
}

class AuthenticationBackLogInEvent extends AuthenticationEvent {}
