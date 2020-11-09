import 'dart:convert';
import 'dart:io';
import 'package:common/common.dart';
import 'package:http/http.dart';
import 'package:repository/model/authorization.dart';
import 'package:retry/retry.dart';
import 'package:repository/exception/exception.dart';
import 'package:repository/repository.dart';

abstract class BaseClient {
  Client _client;
  String _host;
  Authorization _authorization;

  BaseClient(String host, {Client client, Authorization authorization}) {
    _client = client ?? Client();
    _host = host;
    _authorization = authorization;
  }

  Uri _getParsedUrl(String path) {
    return Uri.parse('$_host$path');
  }

  Future<bool> _refreshToken() async {
    try {
      final authorization = Repository().authorization;
      final params = {
        'userId': authorization.userId,
        'socialId': authorization.socialId,
        'socialToken': authorization.socialToken
      };
      log.info(
          '''Call API >> POST >> url: ${_getParsedUrl('/user/refreshToken')} >> body: $params''');

      final response = await _client.post(_getParsedUrl('/user/refreshToken'),
          body: jsonEncode(params));
      log.info(
          '''Call API >> POST >> url: ${_getParsedUrl('/user/refreshToken')} >> RESPONSE >> CODE: ${response.statusCode} >> Body: ${response.body}''');
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        return responseJson['result'];
      }
      return false;
    } catch (e) {
      log.error('Refresh Token Error: $e');
    }
    return false;
  }

  BaseRequest _copyRequest(BaseRequest request) {
    BaseRequest requestCopy;

    if (request is Request) {
      requestCopy = Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is MultipartRequest) {
      requestCopy = MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is StreamedRequest) {
      throw Exception('copying streamed requests is not supported');
    } else {
      throw Exception('request type is unknown, cannot copy');
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return requestCopy;
  }

  dynamic _call(String method, String path, {Map<String, Object> data}) async {
    log.info(
        'Call API >> $method >> url: ${_getParsedUrl(path)} >> body: $data');
    dynamic responseJson;
    try {
      var request = Request(method, _getParsedUrl(path));

      final token = (_authorization ?? Repository().authorization)?.socialToken;
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      if (data != null) {
        request.body = jsonEncode(data);
      }
      responseJson = await retry(
        () async {
          final response = await _client
              .send(request)
              .timeout(const Duration(seconds: 30))
              .then(Response.fromStream);
          return _returnResponse(response);
        },
        retryIf: (e) async {
          log.error('Call API >> url: ${_getParsedUrl(path)} >> Error: $e');
          if (e is UnauthorisedException) {
            if (_authorization == null) {
              _authorization = Repository().authorization;
              if (_authorization == null) {
                return false;
              }
              final token = _authorization.socialToken;
              if (token != null) {
                request.headers['Authorization'] = 'Bearer $token';
              }
              request = _copyRequest(request);
              return true;
            } else {
              final refreshToken = await _refreshToken();
              request = _copyRequest(request);

              return refreshToken;
            }
          }
          return false;
        },
      );
    } on SocketException {
      log.error('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    log.info(
        '''Call API >> $method >> url: ${_getParsedUrl(path)} >> response: $responseJson''');
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        if (responseJson['result'] == false) {
          throw AppException(responseJson);
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      case 501:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            '''Error occured while Communication with Server with StatusCode : ${response.statusCode}''');
    }
  }

  dynamic get(String path) async {
    return await _call('GET', path);
  }

  dynamic post(String path, [dynamic data]) async {
    return await _call('POST', path, data: data);
  }

  dynamic put(String path, [dynamic data]) async {
    return await _call('PUT', path, data: data);
  }

  dynamic delete(String path, [dynamic data]) async {
    return await _call('DELETE', path, data: data);
  }
}
