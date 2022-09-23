part of 'session_bloc.dart';

abstract class SessionEvent {
  const SessionEvent();
}

// event for load stored session for auto login
class SessionLoaded extends SessionEvent {}

// event for user start Guest Mode in Log In Screen
class SessionGuestModeStarted extends SessionEvent {}

class SessionGuestModeEnded extends SessionEvent {}

class SessionUserLoggedIn extends SessionEvent {
  final User loggedInUser;
  final bool justSignUp;

  SessionUserLoggedIn(this.loggedInUser, {this.justSignUp = false});
}

class SessionUserSignedOut extends SessionEvent {
  SessionUserSignedOut();
}

class SessionShouldSetUpMessaging extends SessionEvent {
  SessionShouldSetUpMessaging();
}