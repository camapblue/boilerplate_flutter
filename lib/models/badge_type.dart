enum BadgeType {
  appBarNotification,
  tabbarOptions,
}

extension BadgeTypeExtension on BadgeType {
  String toKey() {
    switch (this) {
      case BadgeType.appBarNotification: return 'app_bar_notification';
      case BadgeType.tabbarOptions: return 'tab_bar_options';
    }
  }
}