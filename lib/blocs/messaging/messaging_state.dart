part of 'messaging_bloc.dart';

abstract class MessagingState extends Equatable {
  @override
  List<Object> get props => [];
}

class MessagingInitial extends MessagingState {
  MessagingInitial() : super();
}

class MessagingTopicsSubscribeSuccess extends MessagingState {
  final List<String> topics;
  MessagingTopicsSubscribeSuccess(this.topics) : super();
}

class MessagingAllTopicsUnsubscribeSuccess extends MessagingState {
  MessagingAllTopicsUnsubscribeSuccess() : super();
}