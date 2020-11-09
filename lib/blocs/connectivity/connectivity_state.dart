
import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  final bool isConnected;

  ConnectivityState([ this.isConnected ]);

  @override
  List<Object> get props => [isConnected];
}

class ConnectivityInitial extends ConnectivityState {
  ConnectivityInitial() : super(true);
}

class ConnectivityUpdateSuccess extends ConnectivityState {
  ConnectivityUpdateSuccess(bool connected) : super(connected);
}