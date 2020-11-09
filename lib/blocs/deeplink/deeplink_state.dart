import 'package:equatable/equatable.dart';
import 'deeplink.dart';

abstract class DeeplinkState extends Equatable {
  @override
  List<Object> get props => null;
}

class DeeplinkInitial extends DeeplinkState {}

class DeeplinkOpenSuccess extends DeeplinkState {
  final Deeplink deeplink;

  DeeplinkOpenSuccess([this.deeplink]);
}

class DeeplinkOpenFailure extends DeeplinkState {
  final String deeplinkURL;

  DeeplinkOpenFailure([this.deeplinkURL]);
}