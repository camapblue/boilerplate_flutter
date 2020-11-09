import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    return _singleton;
  }

  Configs._internal();

  String get logLevel => DotEnv().env['LOG_LEVEL'] ?? 'error';
}
