import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:test/test.dart';

void main() {
  late LoaderBloc loaderBloc;

  setUp(() {
    loaderBloc = LoaderBloc(const Key('loader_bloc'));
  });

  test.tearDownAll(() {
    loaderBloc.close();
  });

  group('LoaderInitial', () {
    test.test('LoaderInitial is set from beginning', () {
      expect(loaderBloc.state, const TypeMatcher<LoaderInitial>());
    });
  });

  group('LoaderRun', () {
    blocTest(
      'emits [LoaderInitial, LoaderRunSuccess] when LoaderRun is added',
      build: () => loaderBloc,
      act: (LoaderBloc? bloc) => bloc?.add(LoaderRun('Loading')),
      expect: () => [isA<LoaderInitial>(), isA<LoaderRunSuccess>()],
    );
  });

  group('LoaderShowed', () {
    blocTest(
      '''
        emits [LoaderInitial, LoaderRunSuccess, LoaderStopSuccess] when LoaderStopped is added
      ''',
      build: () => loaderBloc,
      act: (LoaderBloc? bloc) {
        bloc?.add(LoaderRun('Loading'));
        bloc?.add(LoaderStopped());
      },
      expect: () => [
        isA<LoaderInitial>(),
        isA<LoaderRunSuccess>(),
        isA<LoaderStopSuccess>()
      ],
    );
  });
}
