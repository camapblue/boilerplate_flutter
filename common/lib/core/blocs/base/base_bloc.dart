import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'broadcast.dart';
import 'event_bus.dart';

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> {
  final Key key;
  final Key? closeWithBlocKey;

  BaseBloc(this.key, {required S initialState, this.closeWithBlocKey})
      : super(initialState) {
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null &&
        closeWithBlocKey != const Key('force_to_dispose_bloc')) {
      return;
    }

    EventBus().unsubscribes(key);
    EventBus().unhandle(key);

    otherBlocsUnsubscription();

    await super.close();
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnsubscription() {}

  List<Broadcast> subscribes() {
    return <Broadcast>[];
  }

  void addLater(E event, {Duration after = const Duration(seconds: 1)}) {
    Future.delayed(after, () => add(event));
  }
}
