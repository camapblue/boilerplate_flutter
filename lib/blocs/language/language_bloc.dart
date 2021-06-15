import 'package:boilerplate_flutter/services/setting_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/blocs/base/event_bus.dart';
import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

import 'language.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final SettingService settingService;

  LanguageBloc(Key key, {@required this.settingService}) 
    : super(key, initialState: LanguageInitial(
      settingService.getCurrentLocale(),
      settingService.getSupportedLocales(),
    ));

  factory LanguageBloc.instance() {
    return EventBus().newBloc<LanguageBloc>(Keys.Blocs.languageBloc);
  }

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageUpdated &&
        event.newLanguage.languageCode != state.locale.languageCode) {
      yield LanguageUpdateSuccess(event.newLanguage, state.supportedLocales);
    }
  }
}
