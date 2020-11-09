import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

mixin AppLoader {
  void showAppLoading({String message}) {
    EventBus().event<LoaderBloc>(Keys.Blocs.loaderBloc, LoaderRun(message));
  }

  void hideAppLoading() {
    EventBus().event<LoaderBloc>(Keys.Blocs.loaderBloc, LoaderStopped());
  }
}