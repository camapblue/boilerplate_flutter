
part of 'loader_bloc.dart';

abstract class LoaderState extends Equatable {
  final String? loadingMessage;

  LoaderState([this.loadingMessage]);

  @override
  List<Object> get props => [];
}

class LoaderInitial extends LoaderState {}

class LoaderRunSuccess extends LoaderState {
  LoaderRunSuccess({String? message}): super(message);
}

class LoaderStopSuccess extends LoaderState {}