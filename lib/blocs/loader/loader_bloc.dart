

import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loader_state.dart';
part 'loader_event.dart';

class LoaderBloc extends BaseBloc<LoaderEvent, LoaderState> {
  LoaderBloc(Key key)
      : super(key, initialState: LoaderInitial()) {
        on<LoaderRun>(_onLoaderRun);
        on<LoaderStopped>(_onLoaderStopped);
      }

  factory LoaderBloc.instance() {
    final key = Keys.Blocs.loaderBloc;
    return EventBus().newBlocWithConstructor<LoaderBloc>(
      key,
      () => LoaderBloc(key),
    );
  }

  Future<void> _onLoaderRun(
      LoaderRun event, Emitter<LoaderState> emit) async {
    if (state is LoaderRunSuccess) {
      return;
    }
    emit(LoaderRunSuccess(message: event.loadingMessage));
  }

  Future<void> _onLoaderStopped(
      LoaderStopped event, Emitter<LoaderState> emit) async {
    if (state is LoaderStopSuccess) {
      return;
    }
    emit(LoaderStopSuccess());
  }
}