part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent {
  const ConnectivityEvent();
}

class ConnectivityChanged extends ConnectivityEvent {
  ConnectivityChanged({required this.isConnected});

  final bool isConnected;
}
