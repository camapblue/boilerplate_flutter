import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/core/core.dart';

mixin AppLoader {
  void showAppLoading({String? message}) {
    EventBus().event<LoaderBloc>(Keys.Blocs.loaderBloc, LoaderRun(message));
  }

  void hideAppLoading() {
    EventBus().event<LoaderBloc>(Keys.Blocs.loaderBloc, LoaderStopped());
  }
}