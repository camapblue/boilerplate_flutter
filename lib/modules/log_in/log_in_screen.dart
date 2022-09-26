import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/app_constants.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  
  @override
  State<LogInScreen> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      listener: (_, state) {
        if (state is SessionRunGuestModeSuccess) {
          Navigator.pushReplacementNamed(context, Screens.landing);
        }
      },
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {},
        builder: (_, state) {
          final loading = state is AuthenticationLogInInProgress ||
              state is AuthenticationLogInSuccess;
          return AbsorbPointer(
            absorbing: loading,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  SizedBox(
                    height: 120,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage(AppImagesAsset.appIcon),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    child: Center(
                      child: XText.headlineSmall(
                        AppConstants.AppSologan,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        InkWellButton(
                          onTap: () {
                            EventBus().event<SessionBloc>(
                              Keys.Blocs.sessionBloc,
                              SessionGuestModeStarted(),
                            );
                          },
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 4,
                            bottom: 8,
                          ),
                          child: Text(
                            S.of(context).translate(
                                  Strings.Button.tryAsGuest,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
