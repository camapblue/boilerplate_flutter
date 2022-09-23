import 'package:boilerplate_flutter/constants/constants.dart';

class Deeplink {
  final Screen screen;
  final Map? params;

  Deeplink({this.screen = Screen.invalid, this.params});

  Deeplink copyWith({
    Screen? screen,
    Map? params
  }) {
    return Deeplink(
      screen: screen ?? this.screen,
      params: params ?? this.params
    );
  }
}