import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:common/common.dart';

import '../blocs.dart';

class RetryEvent {
  final Key key;
  final Object event;

  RetryEvent({this.key, this.event});
}

class EventBus {
  static final EventBus _singleton = EventBus._internal();

  factory EventBus() {
    return _singleton;
  }

  List<BaseBloc> _blocs;
  List<Broadcast> _broadcasts;

  List<RetryEvent> _retryEvents;

  EventBus._internal() {
    _blocs = [];
    _broadcasts = [];
    _retryEvents = [];
  }

  T newBloc<T extends BaseBloc>(Key key) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0) {
      return _blocs[found];
    }

    try {
      final T newInstance = blocConstructors[T](key);
      assert(newInstance is BaseBloc,
          'New instance of bloc should be inherited BaseBloc');
      log.trace('New Bloc is created with key = $key');
      _blocs.add(newInstance);
      if (newInstance.subscribes() != null) {
        _broadcasts.addAll(newInstance.subscribes());
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      log.error('Error in new instance of bloc $key: $e');
    }
    throw Exception('Something went wrong in creating bloc $T');
  }

  T newBlocWithConstructor<T extends BaseBloc>(Key key, Function constructor) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0) {
      return _blocs[found];
    }

    try {
      final T newInstance = constructor();
      log.trace('New Bloc is created with key = $key');
      assert(newInstance is BaseBloc,
          'New instance of bloc should be inherited BaseBloc');

      _blocs.add(newInstance);
      if (newInstance.subscribes() != null) {
        _broadcasts.addAll(newInstance.subscribes());
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      log.error('Error in new instance of bloc $key: $e');
    }
    throw Exception('Something went wrong in creating bloc with key $key');
  }

  T blocFromKey<T extends BaseBloc>(Key key) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0 && _blocs[found] is T) {
      return _blocs[found];
    } else {
      log.error('Cannot found bloc with key $key');
    }
    return null;
  }

  void event<T extends BaseBloc>(Key key, Object event,
      {bool retryLater = false}) {
    try {
      final found = _blocs.indexWhere((b) => b.key == key);
      if (found >= 0 && _blocs[found] is T) {
        _blocs[found].add(event);
      } else {
        log.error('Cannot found bloc with key $key for event $event');
        if (retryLater) {
          _retryEvents.add(RetryEvent(key: key, event: event));
        }
      }
    } catch (e) {
      log.error('Call bloc event error: $e');
    }
  }

  void broadcast(String event, {Map params = const {}}) {
    for (final b in _broadcasts) {
      if (b.event == event) {
        b.onNext(params);
      }
    }
  }

  void unsubscribes(Key blocKey) {
    _broadcasts.removeWhere((b) {
      return b.blocKey == blocKey;
    });
  }

  void unhandle(Key blocKey) {
    _blocs.removeWhere((b) {
      return b.key == blocKey || b.closeWithBlocKey == blocKey;
    });
  }

  void _retryEvent<T extends BaseBloc>(Key key) {
    for (var i = 0; i < _retryEvents.length; i++) {
      final retry = _retryEvents[i];
      if (retry.key == key) {
        event<T>(retry.key, retry.event);
        _retryEvents.removeAt(i);
        break;
      }
    }
  }

  // support methods
  void cleanUp({Key parentKey}) {
    final removedKeys = <Key>[];
    final closeKey = parentKey ?? Keys.Blocs.noneDisposeBloc;
    _blocs.removeWhere((b) {
      if (b.closeWithBlocKey == closeKey) {
        removedKeys.add(b.key);
        return true;
      }
      return false;
    });

    _broadcasts.removeWhere((b) {
      return removedKeys.contains(b.blocKey);
    });
  }

  void openDeeplink(String deeplinkURL) {
    event(Keys.Blocs.deeplinkBloc, DeeplinkOpened(deeplinkURL: deeplinkURL));
  }

  Locale getCurrentLocale() {
    return EventBus()
        .blocFromKey<LanguageBloc>(Keys.Blocs.languageBloc)
        ?.state
        ?.locale;
  }
}
