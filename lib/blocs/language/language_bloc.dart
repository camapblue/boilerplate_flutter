import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final SettingService settingService;

  LanguageBloc(super.key, {required this.settingService})
      : super(
          initialState: LanguageInitial(
            settingService.getCurrentLocale(),
            settingService.getSupportedLocales(),
          ),
        ) {
    on<LanguageUpdated>(_onLanguageUpdated);
  }

  factory LanguageBloc.instance() {
    final key = Keys.Blocs.languageBloc;
    return EventBus().newBlocWithConstructor<LanguageBloc>(
      key,
      () => LanguageBloc(
        key,
        settingService: Provider().settingService,
      ),
    );
  }

  void _onLanguageUpdated(LanguageUpdated event, Emitter<LanguageState> emit) {
    if (event.newLanguage.languageCode == state.locale.languageCode) {
      return;
    }
    emit(
      LanguageUpdateSuccess(event.newLanguage, state.supportedLocales),
    );
  }
}
