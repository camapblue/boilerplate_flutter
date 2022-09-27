import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/blocs/mixin/mixin.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_tabbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver, SessionData {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Widget> _tabScreens;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabScreens = allTabbarItems
        .map(
          (e) => e.toScreen(
            onNavigateToTab: (BottomTabbar tab,
                {Map<String, dynamic> params = const {}}) {},
          ),
        )
        .toList();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      AppContext.screenSize = screenSizeFromDevice(screenWidth: size.width);

      await tryToRegisterPushNotification();
    });
  }

  Future<void> tryToRegisterPushNotification() async {
    if (isGuest) {
      return;
    }

    // start registering push notification
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        {}
        break;
      case AppLifecycleState.inactive:
        {}
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildBody() {
    return MultiBlocListener(
      listeners: [
        BlocListener<SessionBloc, SessionState>(
          listenWhen: (previous, current) => current is SessionUserLogInSuccess,
          listener: (_, state) {},
        ),
        BlocListener<DeeplinkBloc, DeeplinkState>(
          listenWhen: (previous, current) => current is DeeplinkOpenSuccess,
          listener: (_, state) {
            if (state is DeeplinkOpenSuccess) {
              // AppRouter(navigator: rootNavigator.currentState)
              //     .navigateTo(state.deeplink);
            }
          },
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: IndexedStack(
          index: _currentIndex,
          children: _tabScreens,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      body: _buildBody(),
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffdddddd))),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            items: allTabbarItems
                .map((e) => e.toNavigationBarItem(context))
                .toList(),
            currentIndex: _currentIndex,
            unselectedItemColor: context.disabledColor,
            selectedItemColor: context.primaryColor,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
