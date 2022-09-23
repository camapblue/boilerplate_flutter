part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationConnectSocialInProgress extends AuthenticationState {}

class AuthenticationLogInInProgress extends AuthenticationState {}

class AuthenticationLogInSuccess extends AuthenticationState {}

class AuthenticationLogInFailure extends AuthenticationState {}
