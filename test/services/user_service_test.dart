import 'package:mockito/mockito.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:repository/repository/user_repository.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserService userService;
  final UserRepository userRepository = MockUserRepository();

  setUp(() {
    userService =
        UserServiceImpl(
          userRepository: userRepository,
        );
  });

  group('logIn()', () {
    test('return instance of user in case get correct socialId & socialToken',
        () async {      

      expect(
          await userService.logIn(
              email: 'email', password: 'password'),
          isNotNull);
    });
  });
}
