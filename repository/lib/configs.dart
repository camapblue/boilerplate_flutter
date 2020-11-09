import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    return _singleton;
  }

  Configs._internal();

  String get baseUrl => DotEnv().env['BASE_URL'];

  String get supportedLanguages => DotEnv().env['SUPPORTED_LANGUAGES'];
}
