import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  static ScreenSize screenSize = ScreenSize.big;
  static BuildContext? navigatorContext;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool hasBloc<T extends Bloc>() {
    try {
      final _ = BlocProvider.of<T>(this);
      return true;
    } catch (_) {}
    return false;
  }

  double responsiveSized(double size) {
    return size * screenSize.ratio();
  }

  double responsiveSizes(List<double> sizes) {
    return sizes[screenSize.index];
  }
}