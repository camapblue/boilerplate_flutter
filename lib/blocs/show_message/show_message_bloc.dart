import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_message_state.dart';
part 'show_message_event.dart';

class ShowMessageBloc extends BaseBloc<ShowMessageEvent, ShowMessageState> {
  ShowMessageBloc(Key key) : super(key, initialState: ShowMessageInitial()) {
    on<WarningMessageShowed>(_onWarningMessageShowed);
    on<ErrorMessageShowed>(_onErrorMessageShowed);
  }

  factory ShowMessageBloc.instance() {
    final key = Keys.Blocs.showMessageBloc;
    return EventBus().newBlocWithConstructor<ShowMessageBloc>(
      key,
      () => ShowMessageBloc(key),
    );
  }

  void _onWarningMessageShowed(
      WarningMessageShowed event, Emitter<ShowMessageState> emit) {
    emit(
      ShowWarningMessageSuccess(
        event.messageKey,
        params: event.params,
        isSuccess: event.isSuccess,
      ),
    );
  }

  void _onErrorMessageShowed(
      ErrorMessageShowed event, Emitter<ShowMessageState> emit) {
    emit(ShowErrorMessageSuccess(event.messageKey, params: event.params));
  }
}
