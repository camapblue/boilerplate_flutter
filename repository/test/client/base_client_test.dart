import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:repository/client/client.dart' as bb;
import 'package:repository/repository.dart';

import '../mock/mock_request.dart';
import 'base_client_test.mocks.dart';

class TestBaseClient extends bb.BaseClient {
  TestBaseClient(
    String host, {
    required Client client,
    Authorization? authorization,
  }) : super(host, client: client, authorization: authorization);
}

@GenerateMocks([Client])
void main() {
  final Client client = MockClient();
  late TestBaseClient testBaseClient;
  const _host = 'http://test.com';

  setUp(() {
    testBaseClient = TestBaseClient(_host, client: client);
  });

  group('get()', () {
    test('return json data when call get api success', () async {
      const path = '/test';
      const responseJson =
          '{ \"result\": true, \"user\": { \"userId\": \"test_user_id\" } }';
      final bytes = utf8.encode(responseJson);

      when(client.send(MockRequest())
          .then((_) async => StreamedResponse(Stream.value(bytes), 200)),);

      final json = await testBaseClient.get(path);
      expect(json['result'], true);
    });

    test('throw bad request exception when call get api fail', () async {
      const path = '/test';
      const responseJson = 'Bad request';
      final bytes = utf8.encode(responseJson);

      when(client.send(MockRequest()))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 400));

      expect(testBaseClient.get(path),
          throwsA(const TypeMatcher<BadRequestException>()));
    });

    test('throw unauthorised exception when call get api fail', () async {
      const path = '/test';
      const responseJson = 'Unauthorised exception';
      final bytes = utf8.encode(responseJson);

      when(client.send(MockRequest()))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 401));

      expect(testBaseClient.get(path),
          throwsA(const TypeMatcher<UnauthorisedException>()));
    });

    test('throw app exception when call get api fail', () async {
      const path = '/test';
      const responseJson =
          '{ \"result\": false, \"msg\": \"error message\", \"code\": 9 }';
      final bytes = utf8.encode(responseJson);

      when(client.send(MockRequest()))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 200));

      expect(
          testBaseClient.get(path), throwsA(const TypeMatcher<AppException>()));
    });
  });
}
