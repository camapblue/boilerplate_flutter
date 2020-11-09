import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:flutter_udid/flutter_udid.dart';

class Device {
  static int getDeviceType() {
    return Platform.isAndroid ? 1 : 2;
  }

  static bool isiOS() {
    return !Platform.isAndroid;
  }

  static Future<String> getUdid() async {
    final isPhysicalDevice = await Device.isPhysicalDevice();
    if (isPhysicalDevice) {
      return FlutterUdid.consistentUdid;
    }

    return DateTime.now().toIso8601String();
  }

  static Future<bool> isPhysicalDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice;
    }

    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice;
  }
}
