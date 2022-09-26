import 'dart:async';
import 'dart:io';
import 'package:common/core/core.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';
part 'connectivity_event.dart';

typedef CheckingInternet = Future<List<InternetAddress>> Function(String host,
    {InternetAddressType type});

class ConnectivityBloc extends BaseBloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  final CheckingInternet _internetCheckingFunction;
  final String _internetCheckingHost;
  late StreamSubscription subscription;

  ConnectivityBloc(
    Key key, {
    Connectivity? connectivity,
    CheckingInternet? internetCheckingFunction,
    String? internetCheckingHost,
  })  : _connectivity = connectivity ?? Connectivity(),
        _internetCheckingHost = internetCheckingHost ?? 'google.com',
        _internetCheckingFunction =
            internetCheckingFunction ?? InternetAddress.lookup,
        super(key, initialState: const ConnectivityInitial()) {
    subscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final isConnected = await _checkConnection();

      if (isConnected != state.isConnected) {
        add(ConnectivityChanged(isConnected));
      }
    });

    on<ConnectivityChecked>(_onConnectivityChecked);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  factory ConnectivityBloc.instance() {
    final key = Keys.Blocs.connectivityBloc;
    return EventBus().newBlocWithConstructor<ConnectivityBloc>(
      key,
      () => ConnectivityBloc(key),
    );
  }

  Future<bool> _checkConnection() async {
    var hasConnection = state.isConnected;
    try {
      final result = await _internetCheckingFunction(_internetCheckingHost);
      hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      hasConnection = false;
    }

    return hasConnection;
  }

  Future<void> _onConnectivityChecked(
      ConnectivityChecked event, Emitter<ConnectivityState> emit) async {
    final isConnected = await _checkConnection();
    if (isConnected != state.isConnected) {
      emit(ConnectivityUpdateSuccess(isConnected));
    }
  }

  Future<void> _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) async {
    emit(ConnectivityUpdateSuccess(event.isConnected));
  }

  @override
  Future<void> close() async {
    await subscription.cancel();

    await super.close();
  }
}
