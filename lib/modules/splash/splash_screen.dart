import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/modules/route_transition/route_transition.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:common/widget/loading_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _topColor = Color(0xFFA4E82C);
const _bottomColor = Color(0xFF378019);

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      BuildContextExtension.screenSize =
          screenSizeFromDevice(screenWidth: size.width);
      log.info('Screen Size >> $size >> ${BuildContextExtension.screenSize}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LaunchingBloc, LaunchingState>(
            listener: (_, state) {
              if (state is LaunchingPreloadDataSuccess) {
                EventBus().event<SessionBloc>(
                    Keys.Blocs.sessionBloc, SessionLoaded());
              } else if (state is LaunchingPreloadDataFailure) {
                EventBus().event<LaunchingBloc>(
                    Keys.Blocs.launchingBloc, LaunchingPreloadDataStarted());
              }
            },
          ),
          BlocListener<SessionBloc, SessionState>(
            listener: (_, state) async {
              await Future.delayed(const Duration(milliseconds: 1500));

              if (state is SessionFirstTimeLaunchSuccess) {
                // await Navigator.of(context).pushReplacementFadeTransition(
                //   routeName: Screens.landing,
                // );
              } else if (state is SessionReadyToLogIn) {
                await Navigator.of(context).pushReplacementFadeTransition(
                  routeName: Screens.logIn,
                );
              } else if (state is SessionRunGuestModeSuccess) {
                await Navigator.of(context).pushReplacementFadeTransition(
                  routeName: Screens.guestMode,
                );
              } else if (state is SessionUserLogInSuccess) {
                await Navigator.of(context)
                    .pushReplacementNamed(Screens.dashboard);
              }
            },
          ),
        ],
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_topColor, _bottomColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AppImage(
                  image: AppImagesAsset.logoSologan,
                  width: 214,
                  height: 240,
                ),
              ),
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: LoadingText(
                        text: S.of(context).translate(Strings.Common.loading),
                        showAfter: const Duration(milliseconds: 1500),
                        textStyle: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Center(
                      child: AppImage(
                        image: AppImagesAsset.copyright,
                        width: 154,
                        height: 12,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
