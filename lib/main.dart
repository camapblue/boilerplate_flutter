import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:boilerplate_flutter/modules/theme/load_theme.dart';
import 'package:boilerplate_flutter/routes.dart';
import 'package:boilerplate_flutter/utils/utils.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';
import 'package:repository/repository.dart';

import 'modules/app/app_showing/app_showing.dart';

import 'blocs/base/simple_bloc_delegate.dart';
import 'blocs/blocs.dart';

Future<void> main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await DotEnv().load('.env'); // load configs based on environment
  await Repository().initialize(); // initialize all required resources
  Provider().isPhysicalDevice = await Device.isPhysicalDevice();
  Provider().packageInfo = await PackageInfo.fromPlatform();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final Messaging _messaging =
      Messaging(firebaseMessaging: FirebaseMessaging());

  @override
  void initState() {
    super.initState();
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
      child: BlocBuilder<LanguageBloc, LanguageState>(
          condition: (previousState, state) {
        return state is LanguageInitial || state is LanguageUpdateSuccess;
      }, builder: (_, languageState) {
        return MaterialApp(
              navigatorKey: _navigatorKey,
              navigatorObservers: [AppRouteObserver()],
              builder: (context, widget) => MultiBlocListener(
                    listeners: [
                      BlocListener<DeeplinkBloc, DeeplinkState>(
                        condition: (previous, current) =>
                            current is DeeplinkOpenSuccess,
                        listener: (_, state) {
                          if (state is DeeplinkOpenSuccess) {
                            AppRouter(navigator: _navigatorKey.currentState)
                                .navigateTo(state.deeplink);
                          }
                        },
                      ),
                      BlocListener<MessagingBloc, MessagingState>(
                        listener: (_, state) async {
                          if (state is MessagingTopicsSubscribeSuccess) {
                            await _messaging.addTopics(state.topics);
                          } else if (state
                              is MessagingAllTopicsUnsubscribeSuccess) {
                            await _messaging.unsubscribeAllTopics();
                          }
                        },
                      ),
                      BlocListener<SessionBloc, SessionState>(
                        condition: (previous, current) =>
                            current is SessionUserReadyToSetUpMessasing,
                        listener: (_, state) async {
                          await Future.delayed(const Duration(seconds: 1));

                          // start to subscribe all user's topics
                        },
                      ),
                    ],
                    child: AppShowing(app: widget, navigatorKey: _navigatorKey),
                  ),
              localizationsDelegates: const [
                SLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: languageState.supportedLocales,
              locale: languageState.locale,
              title: 'BB Football',
              theme: loadTheme(),
              routes: Routes.allRoutes(context),
              initialRoute: '/');
      }),
    );
  }
}
