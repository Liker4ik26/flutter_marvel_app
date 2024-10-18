import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._connectivity)
      : super(const ConnectivityInitialState()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((results) {
      final isConnected =
          results.isNotEmpty && results.first != ConnectivityResult.none;
      add(
        ConnectivityChanged(isConnected: isConnected),
      );
    });

    on<ConnectivityChanged>((event, emit) {
      emit(
        ConnectivitySuccessState(isConnected: event.isConnected),
      );
    });
  }

  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>>?
      _connectivitySubscription;

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
