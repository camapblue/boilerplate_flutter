import 'dart:convert';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/model/model.dart';

import 'package:repository/client/client.dart' as bb;
import 'package:repository/repository.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements Client {}

class TestBaseClient extends bb.BaseClient {
  TestBaseClient(String host, {Client client, Authorization authorization})
      : super(host, client: client, authorization: authorization);
}

void main() {
  Client client = MockHttpClient();
  TestBaseClient testBaseClient;
  final _host = 'http://test.com';

  setUp(() {
    testBaseClient = TestBaseClient(_host, client: client);
  });

  group('get()', () {
    test('return json data when call get api success', () async {
      final path = '/test';
      final responseJson =
          '{ \"result\": true, \"user\": { \"userId\": \"test_user_id\" } }';
      List<int> bytes = utf8.encode(responseJson);

      when(client.send(any))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 200));

      final json = await testBaseClient.get(path);
      expect(json['result'], true);
    });

    test('throw bad request exception when call get api fail', () async {
      final path = '/test';
      final responseJson = 'Bad request';
      List<int> bytes = utf8.encode(responseJson);

      when(client.send(any))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 400));

      expect(testBaseClient.get(path), throwsA(const TypeMatcher<BadRequestException>()));
    });

    test('throw unauthorised exception when call get api fail', () async {
      final path = '/test';
      final responseJson = 'Unauthorised exception';
      List<int> bytes = utf8.encode(responseJson);

      when(client.send(any))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 401));

      expect(testBaseClient.get(path), throwsA(const TypeMatcher<UnauthorisedException>()));
    });

    test('throw app exception when call get api fail', () async {
      final path = '/test';
      final responseJson =
          '{ \"result\": false, \"msg\": \"error message\", \"code\": 9 }';
      List<int> bytes = utf8.encode(responseJson);

      when(client.send(any))
          .thenAnswer((_) async => StreamedResponse(Stream.value(bytes), 200));

      expect(testBaseClient.get(path), throwsA(const TypeMatcher<AppException>()));
    });
  });
}
