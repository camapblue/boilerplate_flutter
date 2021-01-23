import 'package:boilerplate_flutter/global/global.dart';
import 'package:flutter/foundation.dart';

import 'blocs.dart';

final blocConstructors = {
  LanguageBloc: (Key key) =>
      LanguageBloc(key, settingService: Provider().settingService),
  ConnectivityBloc: (Key key) => ConnectivityBloc(key),
  LoaderBloc: (Key key) => LoaderBloc(key),
  AuthenticationBloc: (Key key) =>
      AuthenticationBloc(key, userService: Provider().userService),
  ShowMessageBloc: (Key key) => ShowMessageBloc(key),
  MessagingBloc: (Key key) => MessagingBloc(key),
  SessionBloc: (Key key) => SessionBloc(
        key,
        sessionService: Provider().sessionService,
        userService: Provider().userService,
      ),
  LaunchingBloc: (Key key) => LaunchingBloc(key),
  DeeplinkBloc: (Key key) => DeeplinkBloc(key),
};
