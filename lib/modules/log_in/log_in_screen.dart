import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/app_routing.dart';
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
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        statusBarHeight: MediaQuery.of(context).padding.top,
        center: const XText.headlineSmall('Login'),
      ),
      body: BlocListener<SessionBloc, SessionState>(
        listener: (_, state) {
          if (state is SessionRunGuestModeSuccess) {
            AppRouting().pushNamed(Screens.landing);
          } else if (state is SessionUserLogInSuccess) {
            AppRouting().pushReplacementNamed(Screens.dashboard);
          }
        },
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {},
          builder: (_, state) {
            final loading = state is AuthenticationLogInInProgress ||
                state is AuthenticationLogInSuccess;
            return AbsorbPointer(
              absorbing: loading,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    ValidatorInput(
                      title: 'Email',
                      placeholder: 'Please enter email',
                      textController: _emailTextController,
                      onFieldSubmitted: print,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.disabledColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 6,
                        bottom: 12,
                      ),
                      validatorRules: [
                        InputValidatorRule.require(
                          errorMessage: 'Please enter the name',
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    PasswordInput(
                      title: 'Password',
                      placeholder: 'Please enter password',
                      textController: _passwordTextController,
                      onFieldSubmitted: print,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.disabledColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 6,
                        bottom: 12,
                      ),
                      passwordRule: InputValidatorRule(
                        errorMessage: 'Invalid password',
                        validator: (input) => input != null && input.length > 6,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    XButton.primary(
                      title: 'Sign In',
                      onPressed: () {
                        EventBus().event<AuthenticationBloc>(
                          Keys.Blocs.authenticationBloc,
                          AuthenticationLoggedIn(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          ),
                        );
                      },
                      loading: loading,
                    ),
                    const Expanded(
                      flex: 2,
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
