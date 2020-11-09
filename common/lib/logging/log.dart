
abstract class Log {
  void trace(dynamic message);      // log for tracking - not in production, should remove all

  void debug(dynamic message);      // log for debug - not in production, only for debug purpose

  void info(dynamic message);       // log for event, actions, ...

  void warning(dynamic message);    // log for unexpected value or data, potential lead to bug

  void error(dynamic message);      // log for try/catch

  void fatal(dynamic message);      // app crash, freeze, ...
}