import 'package:mockito/mockito.dart';

import 'package:boilerplate_flutter/services/services.dart';

import 'package:repository/model/model.dart';
import 'package:repository/repository/user_repository.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockSocialNetworkConnect extends Mock implements SocialNetworkConnect {}

void main() {
  UserService userService;
  final UserRepository userRepository = MockUserRepository();
  final SocialNetworkConnect socialNetworkConnect = MockSocialNetworkConnect();

  setUp(() {
    userService =
        UserServiceImpl(
          userRepository: userRepository,
          socialNetworkConnect: socialNetworkConnect,
        );
  });

  group('logIn()', () {
    test('return instance of user in case get correct socialId & socialToken',
        () async {
      when(userRepository.logIn(
              socialId: anyNamed('socialId'),
              socialToken: anyNamed('socialToken'),
              accountType: anyNamed('accountType')))
          .thenAnswer((_) async {
        return User(userId: 'user_id_test');
      });

      expect(
          await userService.logIn(
              socialId: 'social_id', socialToken: 'social_token'),
          isNotNull);
    });
  });
}
