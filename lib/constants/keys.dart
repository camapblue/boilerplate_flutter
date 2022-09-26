// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';

class Keys {
  static _Blocs get Blocs => _Blocs();
}

class _Blocs {
  static final _Blocs _singleton = _Blocs._internal();

  factory _Blocs() {
    return _singleton;
  }

  _Blocs._internal();

  // One instance at the given time
  final Key noneDisposeBloc = const Key('none_dispose_bloc');
  final Key forceToDisposeBloc = const Key('force_to_dispose_bloc');

  final Key languageBloc = const Key('language_bloc');
  final Key connectivityBloc = const Key('connectivity_bloc');
  final Key authenticationBloc = const Key('authentication_bloc');
  final Key loaderBloc = const Key('loader_bloc');
  final Key themeBloc = const Key('theme_bloc');
  final Key showMessageBloc = const Key('show_message_bloc');
  final Key messagingBloc = const Key('messaging_bloc');
  final Key deeplinkBloc = const Key('deeplink_bloc');
  final Key sessionBloc = const Key('session_bloc');
  final Key launchingBloc = const Key('launching_bloc');
}