import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';

import 'deeplink.dart';

class DeeplinkBloc extends BaseBloc<DeeplinkEvent, DeeplinkState> {
  DeeplinkBloc(Key key) : super(key, initialState: DeeplinkInitial());

  factory DeeplinkBloc.instance() {
    return EventBus().newBloc<DeeplinkBloc>(Keys.Blocs.deeplinkBloc);
  }

  @override
  Stream<DeeplinkState> mapEventToState(DeeplinkEvent event) async* {
    if (event is DeeplinkOpened) {
      try {
        var url = event.deeplinkURL.excludePrefixURLIfNeeded();
        if (url.startsWith('/')) {
          url = url.replaceFirst('/', '');
        }
        final comps = url.split('/');
        final epic = comps[0];
        var deeplink = Deeplink();
        switch (epic) {
          case 'epic':
            {
              final screen = comps[1];
              if (screen == 'example') {
                deeplink = deeplink.copyWith(screen: Screen.example);
              }
            }
            break;
        }
        if (deeplink.screen == Screen.invalid) {
          throw Exception();
        }
        yield DeeplinkOpenSuccess(deeplink);
      } catch (e) {
        yield DeeplinkOpenFailure(event.deeplinkURL);
      }
    }
  }
}
