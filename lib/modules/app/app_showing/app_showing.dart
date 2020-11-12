import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/modules/app/loading/loading.dart';
import 'package:boilerplate_flutter/modules/app/lost_connection/lost_connection.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppShowing extends StatefulWidget {
  const AppShowing({Key key, @required this.app, @required this.navigatorKey})
      : super(key: key);

  final Widget app;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<StatefulWidget> createState() {
    return _AppShowingState();
  }
}

class _AppShowingState extends State<AppShowing> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          log.info('App Resumed from Background');
        }
        break;
      case AppLifecycleState.inactive:
        {
          log.info('App Change to Inactive');
        }
        break;
      case AppLifecycleState.paused:
        {
          log.info('App Paused');
        }
        break;
      case AppLifecycleState.detached:
        {
          log.info('Widget is detached');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ShowMessageBloc, ShowMessageState>(
          listener: (_, state) {
            if (state is ShowWarningMessageSuccess) {
              Toast(
                S.of(context).translate(
                      state.messageKey,
                      params: state.params,
                    ),
                success: state.isSuccess,
              ).showWithNavigator(widget.navigatorKey.currentState);
            } else if (state is ShowErrorMessageSuccess) {
              if (BuildContextExtension.navigatorContext != null) {
                PopupDrawer.of(BuildContextExtension.navigatorContext)
                    .error(
                      title: S
                          .of(context)
                          .translate(Strings.Common.errorPopupTitle),
                      message: S.of(context).translate(
                            state.messageKey,
                            params: state.params,
                          ),
                    )
                    .show();
              } else {
                Toast(
                  S.of(context).translate(
                        state.messageKey,
                        params: state.params,
                      ),
                  success: false,
                ).showWithNavigator(widget.navigatorKey.currentState);
              }
            }
          },
        ),
      ],
      child: Stack(
        children: <Widget>[
          widget.app,
          const LostConnection(),
          const Loading(),
        ],
      ),
    );
  }
}
