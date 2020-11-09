abstract class ConnectivityEvent {
  const ConnectivityEvent();
}

class ConnectivityChecked extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  const ConnectivityChanged(this.isConnected);
}