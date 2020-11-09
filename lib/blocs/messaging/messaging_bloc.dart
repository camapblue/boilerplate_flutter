import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'messaging.dart';

class MessagingBloc extends BaseBloc<MessagingEvent, MessagingState> {
  MessagingBloc(
    Key key
  ) : super(key);

  factory MessagingBloc.instance() {
    return EventBus().newBloc<MessagingBloc>(Keys.Blocs.messagingBloc);
  }

  @override
  MessagingState get initialState => MessagingInitial();

  @override
  Stream<MessagingState> mapEventToState(MessagingEvent event) async* {
    if (event is MessagingTopicsSubscribed) {
      yield MessagingTopicsSubscribeSuccess(event.topics);
    } else if (event is MessagingAllTopicsUnsubscribed) {
      yield MessagingAllTopicsUnsubscribeSuccess();
    }
  }
}
