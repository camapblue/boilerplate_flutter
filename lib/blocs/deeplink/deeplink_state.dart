part of 'deeplink_bloc.dart';

abstract class DeeplinkState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeeplinkInitial extends DeeplinkState {}

class DeeplinkOpenSuccess extends DeeplinkState {
  final Deeplink deeplink;

  DeeplinkOpenSuccess(this.deeplink);
}

class DeeplinkOpenFailure extends DeeplinkState {
  final String deeplinkURL;

  DeeplinkOpenFailure(this.deeplinkURL);
}