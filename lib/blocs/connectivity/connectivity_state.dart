
part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  final bool isConnected;

  const ConnectivityState(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}

class ConnectivityInitial extends ConnectivityState {
  const ConnectivityInitial() : super(true);
}

class ConnectivityUpdateSuccess extends ConnectivityState {
  const ConnectivityUpdateSuccess(super.connected);
}