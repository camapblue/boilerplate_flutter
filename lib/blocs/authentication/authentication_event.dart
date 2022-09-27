part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoggedIn({
    required this.email,
    required this.password,
  });
}
