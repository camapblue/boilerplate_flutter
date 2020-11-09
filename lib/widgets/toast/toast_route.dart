import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'toast.dart';

class ToastRoute<T> extends OverlayRoute<T> {
  final ThemeData theme;
  Future<T> get completed => _transitionCompleter.future;
  final Completer<T> _transitionCompleter = Completer<T>();

  Toast toast;
  Builder _builder;
  Alignment _initialAlignment;
  Alignment _endAlignment;

  bool _wasDismissedBySwipe = false;      // not support yet

  T _result;

  @protected
  AnimationController get animationController => _animationController;
  AnimationController _animationController;

  Animation<Alignment> _animation;

  Timer _timer;
  bool isShowing;

  Function _onFinished;

  bool get opaque => false;
  String dismissibleKey = '';

  Duration animationDuration = const Duration(milliseconds: 350);

  ToastRoute(
      {@required this.theme,
      @required this.toast,
      RouteSettings settings})
      : super(settings: settings) {
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
        navigator.pop();
        if (_onFinished != null) {
          _onFinished();
        }
        break;
    }
    changedInternalState();
  }

  @override
  bool get finishedWhenPopped =>
      _animationController.status == AnimationStatus.dismissed;

  AnimationController createAnimationController() {
    assert(
        animationDuration != null &&
            animationDuration >= Duration.zero,
        'Can not reuse a $runtimeType if duration = 0');
    return AnimationController(
      duration: animationDuration,
      debugLabel: debugLabel,
      vsync: navigator,
    );
  }

  Animation<Alignment> createAnimation() {
    assert(animationController != null, 'Can not reuse a $runtimeType');
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
    assert(_animationController != null,
        '$runtimeType.createAnimationController() returned null.');
    _animation = createAnimation();
    assert(_animation != null, '$runtimeType.createAnimation() returned null.');
    super.install();
  }

  @override
  TickerFuture didPush() {
    assert(
        _animationController != null,
        '$runtimeType.didPush called before calling install() or '
        'after calling dispose().');
    _animation.addStatusListener(_handleStatusChanged);
    _configureTimer();
    super.didPush();
    return _animationController.forward();
  }

  @override
  bool didPop(T result) {
    assert(_animationController != null,
    '$runtimeType.didPop called before calling install() '
        'or after calling dispose().');
    assert(!_transitionCompleter.isCompleted,
    'Cannot reuse a $runtimeType after disposing it.');

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
    if (toast.duration != null) {
      if (_timer != null && _timer.isActive) {
        _timer.cancel();
      }
      _timer = Timer(Duration(seconds: toast.duration), () {
        if (isCurrent) {
          _animationController.reverse();
        } else if (isActive) {
          navigator.removeRoute(this);
        }
      });
    } else {
      if (_timer != null) {
        _timer.cancel();
      }
    }
  }

  void _cancelTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    final overlays = <OverlayEntry>[];

    final alignTransition = AlignTransition(
      alignment: _animation,
      child: _builder
    );

    overlays.add(OverlayEntry(
        builder: (BuildContext context) {
          final Widget annotatedChild = Semantics(
            focused: false,
            container: true,
            explicitChildNodes: true,
            child: alignTransition,
          );
          return theme != null
              ? Theme(
                  data: theme,
                  child: annotatedChild,
                )
              : annotatedChild;
        },
        maintainState: false,
        opaque: opaque));

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
    _animationController?.dispose();
    _transitionCompleter.complete(_result);
    super.dispose();
  }
}

ToastRoute showToast<U>(
    {@required BuildContext context, @required Toast toast}) {
  assert(toast != null, 'showToast <==> Toast is null');

  return ToastRoute<U>(
      toast: toast,
      theme: Theme.of(context),
      settings: const RouteSettings(name: ToastRouteName));
}
