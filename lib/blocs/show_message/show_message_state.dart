import 'package:equatable/equatable.dart';

abstract class ShowMessageState extends Equatable {
  final String messageKey;
  final List<dynamic> params;
  final DateTime showTime;

  ShowMessageState([this.messageKey, this.params]) : showTime = DateTime.now();

  @override
  List<Object> get props => [messageKey, params, showTime];
}

class ShowMessageInitial extends ShowMessageState {}

class ShowWarningMessageSuccess extends ShowMessageState {
  final bool isSuccess;

  ShowWarningMessageSuccess(String messageKey,
      {List<dynamic> params = const [], this.isSuccess = false})
      : super(messageKey, params);
}

class ShowErrorMessageSuccess extends ShowMessageState {
  ShowErrorMessageSuccess(String messageKey, {List<dynamic> params = const []})
      : super(messageKey, params);
}
