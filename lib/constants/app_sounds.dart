enum AppSounds {
  alert,
  bell,
}

const _AppSoundAsset = {
  AppSounds.alert: 'sounds/alert.wav',
  AppSounds.bell: 'sounds/bell.mp3'
};

extension AppSoundsExtension on AppSounds {
  String toAssetPath() {
    final assets = _AppSoundAsset[this];
    if (assets != null) {
      return assets;
    }
    return 'sounds/alert.wav';
  }
}