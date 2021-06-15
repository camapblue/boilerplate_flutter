import 'dart:io';

import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/global/provider.dart';
import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Messaging {
  final FirebaseMessaging firebaseMessaging;
  final List<String> subscribedTopics = <String>[];

  Messaging({this.firebaseMessaging});

  Future<void> addTopics(List<String> topics) async {
    final addingTopics = <String>[];
    for (final topic in topics) {
      if (!subscribedTopics.contains(topic)) {
        addingTopics.add(topic);
      }
    }
    if (addingTopics.isEmpty) {
      return;
    }

    await Future.wait(
      addingTopics.map(firebaseMessaging.subscribeToTopic).toList(),
    );
    subscribedTopics.addAll(addingTopics);
  }

  Future<void> unsubscribeAllTopics() async {
    await Future.wait(
      subscribedTopics.map(firebaseMessaging.unsubscribeFromTopic).toList(),
    );
    subscribedTopics.clear();
  }

  void start({List<String> topics = const <String>[]}) {
    if (Platform.isIOS) {
      _iOSRequestPermission();
    }

    firebaseMessaging.getToken().then((String token) async {
      assert(token != null, 'Token is required');
      log.info('Firebase Token: $token');

      try {
        final userService = Provider().userService;
        await userService.registerDeviceIfNeeded(deviceToken: token);

        if (topics.isNotEmpty) {
          await Future.wait(
            topics.map(firebaseMessaging.subscribeToTopic).toList(),
          );
          subscribedTopics.addAll(topics);
        }
      } catch (e) {
        log.error('Register Device Error >> $e');
      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      log.info('Message onReceive >> ${event.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final deeplinkURL = event.data['data']['deeplink'];
      EventBus().openDeeplink(deeplinkURL);
    });
  }

  void _iOSRequestPermission() {
    firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true);
  }
}
