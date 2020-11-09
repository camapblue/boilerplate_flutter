import 'package:audioplayers/audio_cache.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

class Sounds {
  static final Sounds _singleton = Sounds._internal();

  factory Sounds() {
    return _singleton;
  }

  Sounds._internal();

  final AudioCache player = AudioCache();

  Future<void> play({AppSounds sound}) async {
    await player.play(sound.toAssetPath());
  }

  static Future<void> bell() async {
    await Sounds().play(sound: AppSounds.bell);
  }

  static Future<void> alert() async {
    await Sounds().play(sound: AppSounds.alert);
  }
}
