import 'package:equatable/equatable.dart';

abstract class LaunchingState extends Equatable {
  LaunchingState();

  @override
  List<Object> get props => null;
}

class LaunchingInitial extends LaunchingState {}

class LaunchingPreloadDataInProgress extends LaunchingState {}

class LaunchingPreloadDataSuccess extends LaunchingState {}

class LaunchingPreloadDataFailure extends LaunchingState {
  final String errorMessage;

  LaunchingPreloadDataFailure({this.errorMessage});
}
