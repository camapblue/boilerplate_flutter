import 'package:flutter/foundation.dart';

abstract class DeeplinkEvent {
  const DeeplinkEvent();
}

class DeeplinkOpened extends DeeplinkEvent {
  final String deeplinkURL;

  const DeeplinkOpened({@required this.deeplinkURL});
}