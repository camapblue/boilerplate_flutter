import 'dart:ui';
import 'package:repository/repository.dart';

import '../setting_service.dart';

class SettingServiceImpl implements SettingService {
  final SettingRepository _settingRepository;

  SettingServiceImpl({required SettingRepository settingRepository})
      : _settingRepository = settingRepository;

  @override
  Locale getCurrentLocale() {
    return _settingRepository.getCurrentLocale();
  }

  @override
  List<Locale> getSupportedLocales() {
    return _settingRepository.getSupportedLocales();
  }
  
}
