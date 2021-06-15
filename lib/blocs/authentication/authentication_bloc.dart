import 'package:boilerplate_flutter/blocs/constants.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/services/exceptions/exceptions.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:boilerplate_flutter/services/user_service.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:repository/repository.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends BaseBloc<AuthenticationEvent, AuthenticationState> {
  final UserService _userService;
  final SocialNetworkConnect _socialNetworkConnect;

  AuthenticationBloc(Key key,
      {UserService userService, SocialNetworkConnect socialNetworkConnect})
      : _userService = userService,
        _socialNetworkConnect = socialNetworkConnect,
        super(key, initialState: AuthenticationInitial());

  factory AuthenticationBloc.instance() {
    return EventBus()
        .newBloc<AuthenticationBloc>(Keys.Blocs.authenticationBloc);
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedIn(event);
    }

    if (event is AuthenticationBackLogInEvent) {
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedIn(
      AuthenticationLoggedIn event) async* {
    yield AuthenticationConnectSocialInProgress();

    SocialAccount socialAccount;
    try {
      socialAccount = await _socialNetworkConnect.logIn(type: event.type);

      yield AuthenticationLogInInProgress();

      final user = await _userService.logIn(
        socialId: socialAccount.socialId,
        socialToken: socialAccount.token,
        accountType: event.type,
      );

      EventBus().broadcast(
        BroadcastEvent.justLoggedIn,
        params: {'user': user, 'justSignUp': false},
      );

      yield AuthenticationLogInSuccess();
    } catch (e) {
      log.error('Login Error >> $e');

      if (e is AppException &&
          e.errorCode == ErrorCodes.Authentication.accountDoesNotExisted) {
        final socialProfile = await _socialNetworkConnect.getUserProfile(
            socialAccount: socialAccount);

        yield AuthenticationUserDoesNotExisted(
          socialProfile: socialProfile,
        );
      } else if (e is SocialNetworkAppleSignInIsNotAvailableException) {
        showAppError(Strings.Common.appleSignInIsNotAvailable);

        yield AuthenticationLogInFailure();
      } else {
        yield AuthenticationLogInFailure();
      }
    }
  }
}
