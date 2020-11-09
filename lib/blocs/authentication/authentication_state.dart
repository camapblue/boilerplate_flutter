import 'package:equatable/equatable.dart';
import 'package:boilerplate_flutter/models/social_profile.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => null;
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationConnectSocialInProgress extends AuthenticationState {}

class AuthenticationLogInInProgress extends AuthenticationState {}

class AuthenticationLogInSuccess extends AuthenticationState {}

class AuthenticationLogInFailure extends AuthenticationState {}

class AuthenticationUserDoesNotExisted extends AuthenticationState {
  final SocialProfile socialProfile;
  AuthenticationUserDoesNotExisted({this.socialProfile});
}
