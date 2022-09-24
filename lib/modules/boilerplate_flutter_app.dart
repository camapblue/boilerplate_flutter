import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/modules/app/app_showing/app_showing.dart';
import 'package:boilerplate_flutter/modules/theme/load_theme.dart';
import 'package:common/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlevar_router/qlevar_router.dart';

import 'routes.dart';

class BoilerplateFlutterApp extends StatefulWidget {
  const BoilerplateFlutterApp();

  @override
  State<StatefulWidget> createState() {
    return _BoilerplateFlutterAppState();
  }
}

class _BoilerplateFlutterAppState extends State<BoilerplateFlutterApp> {
  final Messaging _messaging =
      Messaging(firebaseMessaging: FirebaseMessaging.instance);

  @override
  void initState() {
    super.initState();

    AppRouter.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(create: (_) => LanguageBloc.instance()),
        BlocProvider<ConnectivityBloc>(
          create: (_) =>
              ConnectivityBloc.instance()..add(ConnectivityChecked()),
        ),
        BlocProvider<LoaderBloc>(create: (_) => LoaderBloc.instance()),
        BlocProvider<ShowMessageBloc>(
            create: (_) => ShowMessageBloc.instance()),
        BlocProvider<DeeplinkBloc>(create: (_) => DeeplinkBloc.instance()),
        BlocProvider<LaunchingBloc>(
          create: (_) =>
              LaunchingBloc.instance()..add(LaunchingPreloadDataStarted()),
        ),
        BlocProvider<SessionBloc>(create: (_) => SessionBloc.instance()),
        BlocProvider<MessagingBloc>(create: (_) => MessagingBloc.instance()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SessionBloc, SessionState>(
            listener: (_, state) {
              log.info('Session State >> $state');
            },
          ),
          BlocListener<DeeplinkBloc, DeeplinkState>(
            listenWhen: (previous, current) => current is DeeplinkOpenSuccess,
            listener: (_, state) {
              if (state is DeeplinkOpenSuccess) {
                // AppRouting(navigator: ).navigateTo(state.deeplink);
              }
            },
          ),
          BlocListener<MessagingBloc, MessagingState>(
            listener: (_, state) async {
              if (state is MessagingTopicsSubscribeSuccess) {
                await _messaging.addTopics(state.topics);
              } else if (state is MessagingAllTopicsUnsubscribeSuccess) {
                await _messaging.unsubscribeAllTopics();
              }
            },
          ),
          BlocListener<SessionBloc, SessionState>(
            listenWhen: (previous, current) =>
                current is SessionUserReadyToSetUpMessasing,
            listener: (_, state) async {
              await Future.delayed(const Duration(seconds: 1));

              // start to subscribe all user's topics
            },
          ),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          buildWhen: (previousState, state) {
            return state is LanguageInitial || state is LanguageUpdateSuccess;
          },
          builder: (_, languageState) {
            return MaterialApp.router(
              routeInformationParser: const QRouteInformationParser(),
              routerDelegate: QRouterDelegate(
                AppRouter.allRoutes(),
                observers: [
                  AppRouteObserver(),
                ],
                initPath: Screens.splash,
              ),
              localizationsDelegates: const [
                SLocalizationsDelegate(),
              ],
              supportedLocales: languageState.supportedLocales,
              locale: languageState.locale,
              useInheritedMediaQuery: true,
              title: 'Boilerplate Web App',
              theme: loadTheme(),
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'Boilerplate Web App',
              builder: (context, child) => AppShowing(app: child!),
              scaffoldMessengerKey: AppRouting().scaffoldMessengerState,
            );
          },
        ),
      ),
    );
  }
}
