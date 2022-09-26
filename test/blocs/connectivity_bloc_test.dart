import 'dart:io';

import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';

import 'connectivity_bloc_test.mocks.dart';

typedef InternetCheckingFunc = Future<List<InternetAddress>> Function(String,
    {InternetAddressType? type});

@GenerateMocks([Connectivity])
void main() {
  late ConnectivityBloc connectivityBloc;
  InternetCheckingFunc internetCheckingFunction;
  final Connectivity connectivity = MockConnectivity();
  final connectionUpdated = PublishSubject<ConnectivityResult>();

  setUp(() {
    internetCheckingFunction = (String host,
            {InternetAddressType? type}) async =>
        [InternetAddress('127.0.0.1')];
    when(connectivity.onConnectivityChanged)
        .thenAnswer((_) => connectionUpdated.stream);

    connectivityBloc = ConnectivityBloc(const Key('connectivity_bloc'),
        connectivity: connectivity,
        internetCheckingFunction: internetCheckingFunction);
  });

  test.tearDownAll(() {
    connectionUpdated.close();
    connectivityBloc.close();
  });

  group('ConnectivityInitial', () {
    test.test('ConnectivityInitial is set state isConnected = true', () {
      expect(connectivityBloc.state, const TypeMatcher<ConnectivityInitial>());
      expect(connectivityBloc.state.isConnected, true);
    });
  });

  group('ConnectivityChecked', () {
    blocTest(
      '''
        emits [ConnectivityInitial, ConnectivityUpdateSuccess] when ConnectivityChecked is added
      ''',
      build: () => connectivityBloc,
      act: (ConnectivityBloc? bloc) async {
        bloc?.add(const ConnectivityChanged(false));
      },
      expect: () =>
          [isA<ConnectivityUpdateSuccess>()],
    );

    blocTest(
      '''
        emits [ConnectivityInitial, ConnectivityUpdateSuccess, ConnectivityUpdateSuccess] when ConnectivityChecked is added
      ''',
      build: () => connectivityBloc,
      act: (ConnectivityBloc? bloc) async {
        bloc?.add(const ConnectivityChanged(false));
        bloc?.add(ConnectivityChecked());
      },
      expect: () => [
        isA<ConnectivityUpdateSuccess>(),
        isA<ConnectivityUpdateSuccess>()
      ],
    );

    blocTest(
      '''
        emits [ConnectivityInitial, ConnectivityUpdateSuccess] when connection is changed
      ''',
      build: () => connectivityBloc,
      act: (ConnectivityBloc? bloc) {
        bloc?.add(const ConnectivityChanged(false));
        connectionUpdated.add(ConnectivityResult.wifi);
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<ConnectivityUpdateSuccess>(),
        isA<ConnectivityUpdateSuccess>()
      ],
    );
  });
}
