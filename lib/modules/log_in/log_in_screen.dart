import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/enum/enum.dart';
import 'package:repository/repository.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  AccountType _accountType;

  List<Widget> _buildAppleSignIn({bool loading, bool connetingSocial}) {
    return <Widget>[
      const SizedBox(
        height: 32,
      ),
      Center(
        child: LoginButton.apple(
          width: 300,
          context: context,
          fontSize: 25,
          isLoading: loading && _accountType == AccountType.apple,
          loadingText: connetingSocial
              ? S.of(context).translate(
                    Strings.Common.connectingSocialAccount,
                  )
              : S.of(context).translate(
                    Strings.Common.signingIn,
                  ),
          onPressed: () {
            _accountType = AccountType.apple;

            EventBus().event<AuthenticationBloc>(
              Keys.Blocs.authenticationBloc,
              AuthenticationLoggedIn(
                type: _accountType,
              ),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<SessionBloc, SessionState>(
        listener: (_, state) {
          if (state is SessionRunGuestModeSuccess) {
            Navigator.pushReplacementNamed(context, Screens.guestMode);
          }
        },
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {},
          builder: (_, state) {
            final loading = state is AuthenticationConnectSocialInProgress ||
                state is AuthenticationLogInInProgress ||
                state is AuthenticationLogInSuccess;
            return AbsorbPointer(
              absorbing: loading,
              child: Container(
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
                    SizedBox(
                      child: Center(
                        child: Text(
                          kAppSologan,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                    Center(
                      child: LoginButton.facebook(
                        context: context,
                        fontSize: 25,
                        width: 300,
                        isLoading:
                            loading && _accountType == AccountType.facebook,
                        loadingText:
                            state is AuthenticationConnectSocialInProgress
                                ? S.of(context).translate(
                                      Strings.Common.connectingSocialAccount,
                                    )
                                : S.of(context).translate(
                                      Strings.Common.loggingIn,
                                    ),
                        onPressed: () {
                          _accountType = AccountType.facebook;

                          EventBus().event<AuthenticationBloc>(
                            Keys.Blocs.authenticationBloc,
                            AuthenticationLoggedIn(
                              type: _accountType,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: LoginButton.google(
                        width: 300,
                        context: context,
                        fontSize: 25,
                        isLoading:
                            loading && _accountType == AccountType.google,
                        loadingText:
                            state is AuthenticationConnectSocialInProgress
                                ? S.of(context).translate(
                                      Strings.Common.connectingSocialAccount,
                                    )
                                : S.of(context).translate(
                                      Strings.Common.loggingIn,
                                    ),
                        onPressed: () {
                          _accountType = AccountType.google;

                          EventBus().event<AuthenticationBloc>(
                            Keys.Blocs.authenticationBloc,
                            AuthenticationLoggedIn(
                              type: _accountType,
                            ),
                          );
                        },
                      ),
                    ),
                    if (Device.isiOS())
                      ..._buildAppleSignIn(
                        loading: loading,
                        connetingSocial:
                            state is AuthenticationConnectSocialInProgress,
                      ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
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
      ),
    );
  }
}
