import 'dart:async';

import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/theme/theme.dart';
import 'toast_route.dart';

extension ToastTheme on ThemeData {
  TextStyle get toastMessageTextStyle =>
      primaryTextTheme.bodyText1!.copyWith(color: darkColor);
}

typedef ToastStatusCallBack = void Function();

const String ToastRouteName = '/ToastRoute';

// ignore: must_be_immutable
class Toast<T extends Object> extends StatefulWidget {
  final String message;
  final bool success;
  final void Function()? onFinished;

  Toast(this.message, {Key? key, this.success = true, this.onFinished})
      : super(key: key);

  int duration = 4;

  ToastRoute<T>? _toastRoute;

  Future<T?> show(BuildContext context) async {
    await Sounds.alert();

    _toastRoute = showToast<T>(context: context, toast: this);

    return Navigator.of(context, rootNavigator: false).push(_toastRoute!);
  }

  Future<T?> showWithNavigator(NavigatorState navigator) async {
    await Sounds.alert();

    _toastRoute = showToast<T>(context: navigator.context, toast: this);

    return navigator.push(_toastRoute!);
  }

  Future<T?> dismiss([T? result]) async {
    if (_toastRoute == null) {
      return null;
    }

    return result;
  }

  @override
  State createState() {
    return _ToastState<T>();
  }
}

class _ToastState<K extends Object> extends State<Toast>
    with TickerProviderStateMixin {
  final Widget _emptyWidget = const SizedBox(width: 0.0, height: 0.0);

  late FocusScopeNode _focusScopeNode;
  late FocusAttachment _focusAttachment;

  GlobalKey backgroundBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _focusScopeNode = FocusScopeNode();
    _focusAttachment = _focusScopeNode.attach(context);
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _focusAttachment.detach();
    super.dispose();
  }

  BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 40.0,
          offset: Offset(0.5, 0.5),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    final appBarHeight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top - 20;

    return Container(
      padding: EdgeInsets.only(top: appBarHeight + 36),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: <Widget>[
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              key: backgroundBoxKey,
              decoration: boxDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _emptyWidget,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 41.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: widget.success ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Icon(
                                widget.success ? Icons.check : Icons.close,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 4.0, right: 0.0, top: 0.0, bottom: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 4.0, right: 8.0),
                                child: Text(
                                  widget.message,
                                  style:
                                      Theme.of(context).toastMessageTextStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
