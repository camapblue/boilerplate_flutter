import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:mockito/mockito.dart';
import 'package:repository/repository.dart';
import 'package:test/test.dart';

class MockUserService extends Mock implements UserService {}

class MockSocialNetworkConnect extends Mock implements SocialNetworkConnect {}

void main() {
  AuthenticationBloc authenticationBloc;
  final UserService userService = MockUserService();
  final SocialNetworkConnect socialNetworkConnect = MockSocialNetworkConnect();

  setUp(() {
    authenticationBloc = AuthenticationBloc(const Key('authentication_bloc'),
        userService: userService, socialNetworkConnect: socialNetworkConnect);
  });

  test.tearDownAll(() {
    authenticationBloc.close();
  });

  group('AuthenticationInitial', () {
    test.test('AuthenticationInitial is set from beginning', () {
      expect(authenticationBloc.initialState,
          const TypeMatcher<AuthenticationInitial>());
    });
  });

  group('AuthenticationLoggedIn', () {
    blocTest(
      '''
        emits [AuthenticationInitial, AuthenticationLogInInProgress, AuthenticationLogInSuccess] when AuthenticationLoggedIn is added
      ''',
      build: () => authenticationBloc,
      act: (bloc) async {
        when(socialNetworkConnect.logIn(type: AccountType.facebook)).thenAnswer(
            (_) async => SocialAccount(
                socialId: 'social_id',
                token: 'token',
                type: AccountType.facebook));

        when(userService.logIn(
                socialId: anyNamed('socialId'),
                socialToken: anyNamed('socialToken')))
            .thenAnswer((_) async => User(userId: '1'));

        bloc.add(const AuthenticationLoggedIn(type: AccountType.facebook));
      },
      expect: [
        isA<AuthenticationInitial>(),
        isA<AuthenticationLogInInProgress>(),
        isA<AuthenticationLogInSuccess>()
      ],
    );

    blocTest(
      '''
        emits [AuthenticationInitial, AuthenticationLogInInProgress, AuthenticationLogInFailure] when AuthenticationLoggedIn is added
      ''',
      build: () => authenticationBloc,
      act: (bloc) async {
        when(socialNetworkConnect.logIn(type: AccountType.facebook)).thenAnswer(
            (_) async => throw Exception());

        bloc.add(const AuthenticationLoggedIn(type: AccountType.facebook));
      },
      expect: [
        isA<AuthenticationInitial>(),
        isA<AuthenticationLogInInProgress>(),
        isA<AuthenticationLogInFailure>()
      ],
    );
  });
}
