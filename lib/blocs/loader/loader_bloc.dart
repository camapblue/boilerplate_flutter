

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

import 'loader.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(Key key)
      : super(key, initialState: LoaderInitial());

  factory LoaderBloc.instance() {
    return EventBus().newBloc<LoaderBloc>(Keys.Blocs.loaderBloc);
  }

  @override
  Stream<LoaderState> mapEventToState(LoaderEvent event) async* {
    if (event is LoaderRun && !(state is LoaderRunSuccess)) {
      yield LoaderRunSuccess(message: event.loadingMessage);
    } else if (event is LoaderStopped && !(state is LoaderStopSuccess)) {
      yield LoaderStopSuccess();
    }
  }
}