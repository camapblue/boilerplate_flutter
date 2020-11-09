abstract class MessagingEvent {
  const MessagingEvent();
}

class MessagingTopicsSubscribed extends MessagingEvent {
  final List<String> topics;
  MessagingTopicsSubscribed(this.topics);
}

class MessagingAllTopicsUnsubscribed extends MessagingEvent {
  MessagingAllTopicsUnsubscribed();
}
