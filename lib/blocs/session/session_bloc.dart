import 'package:boilerplate_flutter/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository.dart';

class SessionBloc extends BaseBloc<SessionEvent, SessionState>
    with AppLoader {
  final SessionService _sessionService;
  final UserService _userService;

  SessionBloc(
    Key key, {
    @required SessionService sessionService,
    @required UserService userService,
  })  : _sessionService = sessionService,
        _userService = userService,
        super(key);

  factory SessionBloc.instance() {
    return EventBus().newBloc<SessionBloc>(Keys.Blocs.sessionBloc);
  }

  @override
  List<Broadcast> subscribes() {
    return [
      Broadcast(
        blocKey: key,
        event: BroadcastEvent.justLoggedIn,
        onNext: (data) {
          final User user = data['user'];
          final justSignUp = data['justSignUp'];

          add(SessionUserLoggedIn(user, justSignUp: justSignUp));
        },
      )
    ];
  }

  @override
  SessionState get initialState => SessionInitial();

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is SessionLoaded) {
      yield* _mapEventSessionLoadedToState(event);
    } else if (event is SessionGuestModeEnded) {
      await _sessionService.markExistGuestMode();

      yield SessionReadyToLogIn();
    } else if (event is SessionGuestModeStarted) {
      
      await _sessionService.markBeInGuestMode();

      yield SessionRunGuestModeSuccess();
    } else if (event is SessionShouldSetUpMessaging &&
        state is SessionUserLogInSuccess) {
      yield SessionUserReadyToSetUpMessasing(
        user: state.loggedInUser,
      );
    } else if (event is SessionUserSignedOut) {
      yield* _mapEventUserSignedOutToState(event);
    } else if (event is SessionUserLoggedIn) {
      final authorization = _sessionService.getLoggedInAuthorization();
      if (authorization != null) {
        logLogIn(
          loggedInUser: event.loggedInUser,
          authorization: authorization,
        );
      }
      try {
        yield SessionUserLogInSuccess(
          user: event.loggedInUser,
          justSignUp: event.justSignUp,
        );
      } catch (_) {
        yield SessionUserLogInSuccess(
          user: event.loggedInUser,
          justSignUp: event.justSignUp,
        );
      }
    }
  }

  Stream<SessionState> _mapEventSessionLoadedToState(
      SessionLoaded event) async* {
    final authorization = _sessionService.getLoggedInAuthorization();
    if (authorization != null) {
      Repository().authorization = authorization;
      log.info('''
              SESSION LOADED 
                >> User ID >> ${Repository().authorization.userId} 
                >> TOKEN >> ${Repository().authorization.socialToken}
            ''');

      final loggedInUser = await _sessionService.getLoggedInUser(forceToUpdate: true);

      yield SessionUserLogInSuccess(
        user: loggedInUser,
      );
    } else {
      if (await _sessionService.isFirstTimeLaunching()) {
        yield SessionFirstTimeLaunchSuccess();
      } else if (await _sessionService.isInGuestMode()) {
        yield SessionRunGuestModeSuccess();
      } else {
        yield SessionReadyToLogIn();
      }
    }
  }

  Stream<SessionState> _mapEventUserSignedOutToState(
      SessionUserSignedOut event) async* {
    showAppLoading(message: Strings.Common.signingOut);

    try {
      await _userService.signOut();

      hideAppLoading();

      EventBus().event<MessagingBloc>(
          Keys.Blocs.messagingBloc, MessagingAllTopicsUnsubscribed());

      yield SessionSignOutSuccess();
    } catch (e) {
      hideAppLoading();
      log.error('Sign out error >> $e');
    }
  }

  void markDoneLandingScreen() {
    _sessionService.markDoneFirstTimeLaunching();
  }
}
