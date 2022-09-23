import 'dart:async';

import 'package:flutter/material.dart';

import 'toast.dart';

class ToastRoute<T> extends OverlayRoute<T> {
  final ThemeData? theme;
  Future<T> get completed => _transitionCompleter.future;
  final Completer<T> _transitionCompleter = Completer<T>();

  Toast toast;
  late Builder _builder;
  Alignment? _initialAlignment;
  Alignment? _endAlignment;

  bool _wasDismissedBySwipe = false; // not support yet

  T? _result;

  @protected
  AnimationController get animationController => _animationController;

  late AnimationController _animationController;

  late Animation<Alignment> _animation;

  Timer? _timer;
  bool isShowing = false;

  void Function()? _onFinished;

  bool get opaque => false;
  String dismissibleKey = '';

  Duration animationDuration = const Duration(milliseconds: 350);

  ToastRoute({
    this.theme,
    required this.toast,
    RouteSettings? settings,
  }) : super(settings: settings) {
    _builder = Builder(builder: (BuildContext innerContext) {
      return Container(
        child: toast,
      );
    });

    _configureAlignment();
    _onFinished = toast.onFinished;
  }

  void _configureAlignment() {
    _initialAlignment = const Alignment(-1.0, -2.0);
    _endAlignment = const Alignment(-1.0, -1.0);
  }

  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        isShowing = true;
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.dismissed:
        isShowing = false;
        navigator?.pop();
        if (_onFinished != null) {
          _onFinished!();
        }
        break;
    }
    changedInternalState();
  }

  @override
  bool get finishedWhenPopped =>
      _animationController.status == AnimationStatus.dismissed;

  AnimationController createAnimationController() {
    return AnimationController(
      duration: animationDuration,
      debugLabel: debugLabel,
      vsync: navigator as TickerProvider,
    );
  }

  Animation<Alignment> createAnimation() {
    return AlignmentTween(begin: _initialAlignment, end: _endAlignment).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCirc,
        reverseCurve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  void install() {
    _animationController = createAnimationController();
    _animation = createAnimation();
    super.install();
  }

  @override
  TickerFuture didPush() {
    _animation.addStatusListener(_handleStatusChanged);
    _configureTimer();
    super.didPush();
    return _animationController.forward();
  }

  @override
  bool didPop(T? result) {
    _result = result;
    _cancelTimer();

    if (_wasDismissedBySwipe) {
      Timer(const Duration(milliseconds: 1000), () {
        _animationController.reset();
      });

      _wasDismissedBySwipe = false;
    } else {
      _animationController.reverse();
    }

    return super.didPop(result);
  }

  void _configureTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(seconds: toast.duration), () {
      if (isCurrent) {
        _animationController.reverse();
      } else if (isActive) {
        navigator?.removeRoute(this);
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final overlays = <OverlayEntry>[];

    final alignTransition =
        AlignTransition(alignment: _animation, child: _builder);

    overlays.add(
      OverlayEntry(
        builder: (BuildContext context) {
          final Widget annotatedChild = Semantics(
            focused: false,
            container: true,
            explicitChildNodes: true,
            child: alignTransition,
          );
          return theme != null
              ? Theme(
                  data: theme!,
                  child: annotatedChild,
                )
              : annotatedChild;
        },
        maintainState: false,
        opaque: opaque,
      ),
    );

    return overlays;
  }

  /// short description of this route useful for debugging
  String get debugLabel => '$runtimeType';

  @override
  String toString() {
    return '$runtimeType(animation: $_animationController)';
  }

  @override
  void dispose() {
    assert(!_transitionCompleter.isCompleted,
        'Cannot dispose a $runtimeType twice.');
    _animationController.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }
}

ToastRoute<U> showToast<U>(
    {required BuildContext context, required Toast toast}) {
  return ToastRoute<U>(
    toast: toast,
    theme: Theme.of(context),
    settings: const RouteSettings(name: ToastRouteName),
  );
}
