import 'package:common/configs.dart';
import 'package:logger/logger.dart';

import 'log.dart';

class LogImpl implements Log {
  static final LogImpl _singleton = LogImpl._internal();

  static Level _getLogLevel() {
    final logLevel = Configs().logLevel;
    var level = Level.error;
    switch (logLevel) {
      case 'trace':
        level = Level.verbose;
        break;
      case 'debug':
        level = Level.debug;
        break;
      case 'info':
        level = Level.info;
        break;
      case 'warning':
        level = Level.warning;
        break;
      case 'none':
        level = Level.nothing;
        break;
    }
    return level;
  }

  factory LogImpl() {
    Logger.level = _getLogLevel();
    return _singleton;
  }

  LogImpl._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  @override
  void debug(message) {
    _logger.d(message);
  }

  @override
  void error(message) {
    _logger.e(message);
  }

  @override
  void fatal(message) {
    _logger.wtf(message);
  }

  @override
  void info(message) {
    _logger.i(message);
  }

  @override
  void trace(message) {
    _logger.v(message);
  }

  @override
  void warning(message) {
    _logger.w(message);
  }
}
