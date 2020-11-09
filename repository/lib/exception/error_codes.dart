class ErrorCodes {
  static _Authentication get Authentication => _Authentication();
}

class _Authentication {
  static final _Authentication _singleton = _Authentication._internal();

  factory _Authentication() {
    return _singleton;
  }

  _Authentication._internal();

  // One instance at the given time
  final int accountDoesNotExisted = 9;
}
