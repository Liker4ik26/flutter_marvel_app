part of 'connectivity_bloc.dart';

abstract class ConnectivityState {
  const ConnectivityState();
}

final class ConnectivityInitialState extends ConnectivityState {
  const ConnectivityInitialState();
}

final class ConnectivitySuccessState extends ConnectivityState {
  const ConnectivitySuccessState({required this.isConnected});

  final bool isConnected;
}
