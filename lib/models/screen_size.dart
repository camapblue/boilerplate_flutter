enum ScreenSize {
  big,
  medium,
  small
}

ScreenSize screenSizeFromDevice({double screenWidth}) {
  if (screenWidth < 360.0) {
    return ScreenSize.small;
  } else if (screenWidth < 414) {
    return ScreenSize.medium;
  }
  return ScreenSize.big;
}

extension ScreenSizeExtension on ScreenSize {
  double ratio() {
    switch (this) {
      case ScreenSize.big: return 1.0;
      case ScreenSize.medium: return 0.85;
      case ScreenSize.small: return 0.7;
    }
    return 1.0;
  }
}