// ignore_for_file: constant_identifier_names

enum AppIcons {
  error,
  placeholder,
  empty,
  info,
  checked,
  avatarPlaceholder,
  bell,
  apple,
  arrowDown,
  arrowLeft,
  arrowRight,
  search,
  closeCircle,
}

const _AppIconsAsset = {
  AppIcons.error: 'assets/icons/error.svg',
  AppIcons.placeholder: 'assets/icons/placeholder.svg',
  AppIcons.empty: 'assets/icons/empty.svg',
  AppIcons.info: 'assets/icons/info.svg',
  AppIcons.checked: 'assets/icons/checked.svg',
  AppIcons.avatarPlaceholder: 'assets/icons/avatar_placeholder.svg',
  AppIcons.bell: 'assets/icons/bell.svg',
  AppIcons.apple: 'assets/icons/apple.svg',
  AppIcons.arrowDown: 'assets/icons/arrow_down.svg',
  AppIcons.arrowLeft: 'assets/icons/arrow_left.svg',
  AppIcons.arrowRight: 'assets/icons/arrow_right.svg',
  AppIcons.search: 'assets/icons/search.svg',
  AppIcons.closeCircle: 'assets/icons/close_circle.svg',
};

extension AppIconsExtension on AppIcons {
  String toAssetName() {
    final assets = _AppIconsAsset[this];
    if (assets != null) {
      return assets;
    }
    return 'assets/icons/placeholder.svg';
  }
}