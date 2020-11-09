import 'package:boilerplate_flutter/blocs/mixin/mixin.dart';
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/blocs/blocs.dart';

import 'package:repository/repository.dart';

import 'broadcast.dart';
import 'event_bus.dart';

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> with Analytics, MessageShowing {
  final Key key;
  final Key closeWithBlocKey;

  BaseBloc(this.key, {this.closeWithBlocKey}) : super() {
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null &&
        closeWithBlocKey != Keys.Blocs.forceToDisposeBloc) {
      return;
    }

    EventBus().unsubscribes(key);
    EventBus().unhandle(key);

    otherBlocsUnsubscription();

    await super.close();
  }

  void showAppError(String messageKey, {List<dynamic> params = const []}) {
    EventBus().event<ShowMessageBloc>(
      Keys.Blocs.showMessageBloc,
      ErrorMessageShowed(
        messageKey,
        params: params,
      ),
    );
  }

  void handleException(Exception e) {
    if (e is ApiException) {
      log.error('Api Error >> $e');
      showAppError(e.errorMessage);
    } else if (e is AppException) {
      log.error('App Error >> $e');
      showAppError(e.errorMessage);
    }
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnsubscription() {}

  List<Broadcast> subscribes() {
    return null;
  }

  void addLater(Object event, {Duration after = const Duration(seconds: 1)}) {
    Future.delayed(after, () {
      add(event);
    });
  }
}
