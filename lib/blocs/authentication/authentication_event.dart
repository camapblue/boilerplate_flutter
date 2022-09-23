part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  const AuthenticationLoggedIn();
}
