
import 'package:equatable/equatable.dart';

abstract class LoaderState extends Equatable {
  final String loadingMessage;

  LoaderState([this.loadingMessage]);

  @override
  List<Object> get props => null;
}

class LoaderInitial extends LoaderState {}

class LoaderRunSuccess extends LoaderState {
  LoaderRunSuccess({String message}): super(message);
}

class LoaderStopSuccess extends LoaderState {}