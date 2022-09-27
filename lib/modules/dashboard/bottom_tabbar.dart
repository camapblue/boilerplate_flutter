import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/modules/account/account_screen.dart';
import 'package:boilerplate_flutter/modules/home/home_screen.dart';
import 'package:boilerplate_flutter/modules/options/options_screen.dart';
import 'package:flutter/material.dart';

import 'tabbar_icon.dart';

enum BottomTabbar { home, options, account }
typedef OnNavigateToTab = void Function(BottomTabbar tab,
    {Map<String, dynamic> params});

List<BottomTabbar> get allTabbarItems => [
      BottomTabbar.home,
      BottomTabbar.options,
      BottomTabbar.account,
    ];

BottomTabbar bottomBarFromIndex(int index) {
  return BottomTabbar.values[index];
}

extension BottomTabbarExtension on BottomTabbar {
  Widget toScreen({OnNavigateToTab? onNavigateToTab}) {
    switch (this) {
      case BottomTabbar.home:
        return const HomeScreen();
      case BottomTabbar.options:
        return const OptionsScreen();
      case BottomTabbar.account:
        return const AccountScreen();
    }
  }

  BadgeType? toBadgeType() {
    switch (this) {
      case BottomTabbar.options:
        return BadgeType.tabbarOptions;
      default:
        break;
    }
    return null;
  }

  String toTitle() {
    switch (this) {
      case BottomTabbar.home:
        return Strings.Dashboard.tabbarHome;
      case BottomTabbar.options:
        return Strings.Dashboard.tabbarOptions;
      case BottomTabbar.account:
        return Strings.Dashboard.tabbarAccount;
    }
  }

  IconData _toIcon() {
    switch (this) {
      case BottomTabbar.home:
        return Icons.home;
      case BottomTabbar.options:
        return Icons.settings;
      case BottomTabbar.account:
        return Icons.account_box;
    }
  }

  BottomNavigationBarItem toNavigationBarItem(BuildContext context) {
    final badgeType = toBadgeType();

    return BottomNavigationBarItem(
      icon: TabbarIcon(
        icon: Icon(
          _toIcon(),
          size: 22,
          color: context.iconColor,
        ),
        badgeType: badgeType,
      ),
      activeIcon: TabbarIcon(
        icon: Icon(
          _toIcon(),
          size: 22,
          color: context.iconColor,
        ),
        badgeType: badgeType,
      ),
      label: S.of(context).translate(toTitle()),
    );
  }
}
