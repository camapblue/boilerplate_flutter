part of 'loader_bloc.dart';

abstract class LoaderEvent {
  const LoaderEvent();
}

class LoaderRun extends LoaderEvent {
  final String? loadingMessage;
  LoaderRun(this.loadingMessage);
}

class LoaderStopped extends LoaderEvent {}