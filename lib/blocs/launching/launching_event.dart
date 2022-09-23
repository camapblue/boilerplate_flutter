part of 'launching_bloc.dart';

abstract class LaunchingEvent {
  const LaunchingEvent();
}

class LaunchingPreloadDataStarted extends LaunchingEvent {}