// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, lines_longer_than_80_chars

class Strings {
  static _Common get Common => _Common();

  static _Button get Button => _Button();

  static _ShowMessage get ShowMessage => _ShowMessage();

  static _Dashboard get Dashboard => _Dashboard();
}

// Common for some test really commonly that can be used in many apps
class _Common {
  final String appName = 'Boilerplate';
  
  final String error = 'common.error';
  final String loading = 'common.loading';

  final String noInternetConnection = 'common.no_internet_connection';
}

class _Button {
  final String signIn = 'button.signIn';
  
  final String tryAsGuest = 'button.try_as_guest';
}

class _ShowMessage {
  final String settingUpdated = 'show_message.setting_updated';
}

class _Dashboard {
  final String tabbarHome = 'dashboard.tabbar.home';
  final String tabbarOptions = 'dashboard.tabbar.options';
  final String tabbarAccount = 'dashboard.tabbar.account';
}
