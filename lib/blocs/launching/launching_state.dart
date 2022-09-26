part of 'launching_bloc.dart';

abstract class LaunchingState extends Equatable {
  const LaunchingState();

  @override
  List<Object> get props => [];
}

class LaunchingInitial extends LaunchingState {}

class LaunchingPreloadDataInProgress extends LaunchingState {}

class LaunchingPreloadDataSuccess extends LaunchingState {}

class LaunchingPreloadDataFailure extends LaunchingState {
  final String? errorMessage;

  const LaunchingPreloadDataFailure({this.errorMessage});
}
