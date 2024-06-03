import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:common/common.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'deeplink_state.dart';
part 'deeplink_event.dart';

class DeeplinkBloc extends BaseBloc<DeeplinkEvent, DeeplinkState> {
  DeeplinkBloc(super.key) : super(initialState: DeeplinkInitial()) {
    on<DeeplinkOpened>(_onDeeplinkOpened);
  }

  factory DeeplinkBloc.instance() {
    final key = Keys.Blocs.deeplinkBloc;
    return EventBus().newBlocWithConstructor<DeeplinkBloc>(
      key,
      () => DeeplinkBloc(key),
    );
  }

  Future<void> _onDeeplinkOpened(
      DeeplinkOpened event, Emitter<DeeplinkState> emit) async {
    try {
      var url = event.deeplinkURL.excludePrefixURLIfNeeded();
      if (url.startsWith('/')) {
        url = url.replaceFirst('/', '');
      }
      final comps = url.split('/');
      final epic = comps[0];
      var deeplink = Deeplink();
      switch (epic) {
        case 'epic':
          {
            final screen = comps[1];
            if (screen == 'example') {
              deeplink = deeplink.copyWith(screen: Screen.example);
            }
          }
          break;
      }
      if (deeplink.screen == Screen.invalid) {
        throw Exception();
      }
      emit(DeeplinkOpenSuccess(deeplink));
    } catch (e) {
      emit(DeeplinkOpenFailure(event.deeplinkURL));
    }
  }
}
