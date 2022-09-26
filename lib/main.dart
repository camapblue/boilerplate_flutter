import 'dart:async';

import 'package:common/core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:repository/repository.dart';

import 'modules/boilerplate_flutter_app.dart';

Future<void> main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Provider().isPhysicalDevice = await Device.isPhysicalDevice();
  Provider().packageInfo = await PackageInfo.fromPlatform();

  await Future.wait([
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true),
    Repository().initialize(),
    AppCaching().preloadBeforeAppStart(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    ),
  ]);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  AppCaching().devicePixelRatio = widgetBinding.window.devicePixelRatio;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  Bloc.observer = SimpleBlocObserver();

  runApp(const BoilerplateFlutterApp());
}
