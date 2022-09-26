import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/client/client.dart';
import 'package:repository/dao/dao.dart';

import 'package:repository/repository.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserClient, UserDao])
void main() {
  final UserClient userClient = MockUserClient();
  final UserDao userDao = MockUserDao();
  late UserRepository userRepository;

  setUp(() {
    userRepository = UserRepositoryImpl(
      userClient: userClient,
      userDao: userDao,
    );
  });

  group('saveUser()', () {
    test('make sure call saveUser method of UserDao', () async {
      final user = User.test();
      await userRepository.saveUser(user);

      verify(userDao.saveUser(user)).called(1);
    });
  });

  group('logIn()', () {
    test('''
          return User instance in case socialId, socialToken & accountType are correct
        ''', () async {
      final user = User.test();

      when(userClient.getProfile()).thenAnswer((_) async => user);
      final loggedInUser = await userRepository.getLatestLoggedInUser();
      expect(
        loggedInUser,
        user,
      );
    });
  });
}
