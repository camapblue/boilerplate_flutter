import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

import 'show_message.dart';

class ShowMessageBloc extends BaseBloc<ShowMessageEvent, ShowMessageState> {
  ShowMessageBloc(Key key) : super(key, initialState: ShowMessageInitial());

  factory ShowMessageBloc.instance() {
    return EventBus().newBloc<ShowMessageBloc>(Keys.Blocs.showMessageBloc);
  }

  @override
  Stream<ShowMessageState> mapEventToState(ShowMessageEvent event) async* {
    if (event is WarningMessageShowed) {
      yield ShowWarningMessageSuccess(
        event.messageKey,
        params: event.params,
        isSuccess: event.isSuccess,
      );
    } else if (event is ErrorMessageShowed) {
      yield ShowErrorMessageSuccess(event.messageKey, params: event.params);
    }
  }
}
