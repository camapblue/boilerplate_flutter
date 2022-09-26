import 'dart:async';

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:just_audio/just_audio.dart';

class Sounds {
  static final Sounds _singleton = Sounds._internal();

  factory Sounds() {
    return _singleton;
  }

  Sounds._internal();

  final AudioPlayer player = AudioPlayer();

  Future<void> play({required AppSounds sound}) async {
    await player.setAsset(sound.toAssetPath());
    unawaited(player.play());
  }

  static Future<void> bell() async {
    await Sounds().play(sound: AppSounds.bell);
  }

  static Future<void> alert() async {
    await Sounds().play(sound: AppSounds.alert);
  }
}
