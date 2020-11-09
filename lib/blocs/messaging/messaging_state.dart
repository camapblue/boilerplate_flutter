import 'package:equatable/equatable.dart';

abstract class MessagingState extends Equatable {
  @override
  List<Object> get props => null;
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