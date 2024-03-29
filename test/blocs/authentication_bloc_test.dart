import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/repository.dart';

import 'authentication_bloc_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  late AuthenticationBloc authenticationBloc;
  final UserService userService = MockUserService();

  setUp(() {
    authenticationBloc = AuthenticationBloc(
      const Key('authentication_bloc'),
      userService: userService,
    );
  });

  test.tearDownAll(() {
    authenticationBloc.close();
  });

  group('AuthenticationInitial', () {
    test.test('AuthenticationInitial is set from beginning', () {
      expect(
          authenticationBloc.state, const TypeMatcher<AuthenticationInitial>());
    });
  });

  group('AuthenticationLoggedIn', () {
    blocTest(
      '''
        emits [AuthenticationInitial, AuthenticationLogInInProgress, AuthenticationLogInSuccess] when AuthenticationLoggedIn is added
      ''',
      build: () => authenticationBloc,
      act: (AuthenticationBloc? bloc) async {
        when(
          userService.logIn(
            email: 'email@gmail.com',
            password: 'password',
          ),
        ).thenAnswer((_) async => User.test());

        bloc?.add(const AuthenticationLoggedIn(
          email: 'email@gmail.com',
          password: 'password',
        ));
      },
      expect: () => [
        isA<AuthenticationLogInInProgress>(),
        isA<AuthenticationLogInSuccess>()
      ],
    );
  });
}
