import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    return _singleton;
  }

  Configs._internal();

  bool get isProd => environment == 'prod';

  String get environment => DotEnv().env['ENVIRONMENT'];
}
