import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

import 'launching.dart';

class LaunchingBloc extends BaseBloc<LaunchingEvent, LaunchingState> {
  LaunchingBloc(Key key) : super(key);

  factory LaunchingBloc.instance() {
    return EventBus().newBloc<LaunchingBloc>(Keys.Blocs.launchingBloc);
  }

  @override
  LaunchingState get initialState => LaunchingInitial();

  @override
  Stream<LaunchingState> mapEventToState(LaunchingEvent event) async* {
    if (event is LaunchingPreloadDataStarted) {
      try {
        yield LaunchingPreloadDataInProgress();

        // do something
        
        yield LaunchingPreloadDataSuccess();
      } catch (e) {
        log.error(e.toString());
        yield LaunchingPreloadDataFailure(errorMessage: e.toString());
      }
    }
  }
}
