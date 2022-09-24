import 'package:common/common.dart';

class Configs {
  static final Configs _singleton = Configs._internal();

  factory Configs() {
    if (_singleton._configs == null) {
      try {
        _singleton._configs = {};
        const String.fromEnvironment('env').split('|').forEach((comp) {
          if (comp.isNotEmpty) {
            final vars = comp.split('=');
            _singleton._configs[vars[0]] = vars[1];
          }
        });
      } catch (e) {
        log.error('Error >> $e');
        _singleton._configs = {};
      }
    }
    return _singleton;
  }

  Configs._internal();
  dynamic _configs;

  String get baseUrl => _configs['BASE_URL'] ?? 'http://example.com';
  String get supportedLanguages => _configs['SUPPORTED_LANGUAGES'] ?? 'en,vi';
}
