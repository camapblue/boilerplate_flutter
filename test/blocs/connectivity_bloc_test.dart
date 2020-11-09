import 'dart:io';

import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';
import 'package:test/test.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  ConnectivityBloc connectivityBloc;
  final CheckingInternet internetCheckingFunction = (String host,
          {InternetAddressType type}) async =>
      [InternetAddress('127.0.0.1')];
  final Connectivity connectivity = MockConnectivity();
  final PublishSubject<ConnectivityResult> _connectionUpdated =
      PublishSubject<ConnectivityResult>();

  setUp(() {
    when(connectivity.onConnectivityChanged)
        .thenAnswer((_) => _connectionUpdated.stream);

    connectivityBloc = ConnectivityBloc(Key('connectivity_bloc'),
        connectivity: connectivity,
        internetCheckingFunction: internetCheckingFunction);
  });

  test.tearDownAll(() {
    _connectionUpdated.close();
    connectivityBloc.close();
  });

  group('ConnectivityInitial', () {
    test.test('ConnectivityInitial is set state isConnected = true', () {
      expect(connectivityBloc.initialState,
          const TypeMatcher<ConnectivityInitial>());
      expect(connectivityBloc.initialState.isConnected, true);
    });
  });

  group('ConnectivityChecked', () {
    blocTest(
      'emits [ConnectivityInitial, ConnectivityUpdateSuccess] when ConnectivityChecked is added',
      build: () => connectivityBloc,
      act: (bloc) async {
        bloc.add(ConnectivityChanged(false));
      },
      expect: [isA<ConnectivityInitial>(), isA<ConnectivityUpdateSuccess>()],
    );

    blocTest(
      'emits [ConnectivityInitial, ConnectivityUpdateSuccess, ConnectivityUpdateSuccess] when ConnectivityChecked is added',
      build: () => connectivityBloc,
      act: (bloc) async {
        bloc.add(ConnectivityChanged(false));
        bloc.add(ConnectivityChecked());
      },
      expect: [
        isA<ConnectivityInitial>(),
        isA<ConnectivityUpdateSuccess>(),
        isA<ConnectivityUpdateSuccess>()
      ],
    );

    blocTest(
      'emits [ConnectivityInitial, ConnectivityUpdateSuccess] when connection is changed',
      build: () => connectivityBloc,
      act: (bloc) async {
        await bloc.add(ConnectivityChanged(false));
        _connectionUpdated.add(ConnectivityResult.wifi);
      },
      wait: const Duration(milliseconds: 300),
      expect: [
        isA<ConnectivityInitial>(),
        isA<ConnectivityUpdateSuccess>(),
        isA<ConnectivityUpdateSuccess>()
      ],
    );
  });
}
