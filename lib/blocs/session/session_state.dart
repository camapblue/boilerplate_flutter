import 'package:equatable/equatable.dart';
import 'package:repository/model/model.dart';

abstract class SessionState extends Equatable {
  final User loggedInUser;
  final DateTime lastUpdatedTime;

  SessionState({
    this.loggedInUser,
    this.lastUpdatedTime,
  });

  @override
  List<Object> get props => [loggedInUser, lastUpdatedTime];
}

class SessionInitial extends SessionState {
  SessionInitial() : super();
}

class SessionFirstTimeLaunchSuccess extends SessionState {
  SessionFirstTimeLaunchSuccess() : super();
}

class SessionReadyToLogIn extends SessionState {
  SessionReadyToLogIn() : super();
}

class SessionRunGuestModeSuccess extends SessionState {
  SessionRunGuestModeSuccess() : super();
}

class SessionUserLogInSuccess extends SessionState {
  final bool justSignUp;

  SessionUserLogInSuccess({
    User user,
    this.justSignUp = false,
  }) : super(
          loggedInUser: user,
          lastUpdatedTime: DateTime.now(),
        );
}

class SessionUserReadyToSetUpMessasing extends SessionState {
  SessionUserReadyToSetUpMessasing({
    User user,
  }) : super(
          loggedInUser: user,
        );
}

class SessionSignOutSuccess extends SessionState {
  SessionSignOutSuccess() : super();
}
