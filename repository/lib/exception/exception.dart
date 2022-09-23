class ApiException implements Exception {
  final String _message;
  final String? _prefix;

  ApiException(this._message, [this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }

  String get errorMessage => '$_prefix$_message';
}

class FetchDataException extends ApiException {
  FetchDataException(String message)
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class ServerErrorException extends ApiException {
  ServerErrorException([message]) : super(message, 'Server Error: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException(String message) : super(message, 'Invalid Input: ');
}

class InvalidResponseException extends ApiException {
  InvalidResponseException(String message)
      : super(message, 'Invalid Response: ');
}

class AppException implements Exception {
  final String _message;
  final int _code;

  AppException(Map<String, dynamic> json)
      : _code = json['code'],
        _message = json['msg'];

  @override
  String toString() {
    return '$_code $_message';
  }

  int get errorCode => _code;

  String get errorMessage => _message;
}
