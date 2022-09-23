part of 'show_message_bloc.dart';

abstract class ShowMessageEvent extends Equatable {
  const ShowMessageEvent();

  @override
  List<Object> get props => [];
}

class WarningMessageShowed extends ShowMessageEvent {
  final String messageKey;
  final List<dynamic> params;
  final bool isSuccess;

  const WarningMessageShowed(
    this.messageKey, {
    this.params = const [],
    this.isSuccess = false,
  });

  @override
  List<Object> get props => [messageKey];
}

class ErrorMessageShowed extends ShowMessageEvent {
  final String messageKey;
  final List<dynamic> params;

  const ErrorMessageShowed(this.messageKey, {this.params = const []});

  @override
  List<Object> get props => [messageKey];
}
