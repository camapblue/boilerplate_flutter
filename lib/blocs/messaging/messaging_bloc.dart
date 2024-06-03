import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messaging_state.dart';
part 'messaging_event.dart';

class MessagingBloc extends BaseBloc<MessagingEvent, MessagingState> {
  MessagingBloc(super.key) : super(initialState: MessagingInitial()) {
    on<MessagingTopicsSubscribed>(_onMessagingTopicsSubcribed);
    on<MessagingAllTopicsUnsubscribed>(_onMessagingAllTopicsUnsubcribed);
  }

  factory MessagingBloc.instance() {
    final key = Keys.Blocs.messagingBloc;
    return EventBus()
        .newBlocWithConstructor<MessagingBloc>(key, () => MessagingBloc(key));
  }

  Future<void> _onMessagingTopicsSubcribed(
      MessagingTopicsSubscribed event, Emitter<MessagingState> emit) async {
    emit(MessagingTopicsSubscribeSuccess(event.topics));
  }

  Future<void> _onMessagingAllTopicsUnsubcribed(
      MessagingAllTopicsUnsubscribed event,
      Emitter<MessagingState> emit) async {
    emit(MessagingAllTopicsUnsubscribeSuccess());
  }
}
