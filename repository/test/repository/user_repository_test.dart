import 'package:mockito/mockito.dart';
import 'package:repository/client/client.dart';
import 'package:repository/dao/dao.dart';

import 'package:repository/model/model.dart';
import 'package:repository/repository/impl/user_repository_impl.dart';
import 'package:repository/repository/user_repository.dart';
import 'package:test/test.dart';

class MockUserClient extends Mock implements UserClient {}

class MockUserDao extends Mock implements UserDao {}

void main() {
  UserClient userClient = MockUserClient();
  UserDao userDao = MockUserDao();
  UserRepository userRepository;

  setUp(() {
    userRepository =
        UserRepositoryImpl(userClient: userClient, userDao: userDao);
  });

  group('saveUser()', () {
    test('make sure call saveUser method of UserDao', () async {
      final user = User(userId: '1');
      await userRepository.saveUser(user);

      verify(userDao.saveUser(user)).called(1);
    });
  });

  group('logIn()', () {
    test(
        'return User instance in case socialId, socialToken & accountType are correct',
        () async {
      final user = User(userId: '1');
      when(userClient.logIn(
              socialId: anyNamed('socialId'),
              socialToken: anyNamed('socialToken'),
              accountType: anyNamed('accountType')))
          .thenAnswer((_) async => user);

      expect(
          await userRepository.logIn(
              socialId: 'socialId', socialToken: 'socialToken', accountType: 1),
          user);
    });
  });
}
