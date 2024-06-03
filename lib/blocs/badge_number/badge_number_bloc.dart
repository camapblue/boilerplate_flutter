import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:common/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'badge_number_event.dart';
part 'badge_number_state.dart';

class BadgeNumberBloc extends BaseBloc<BadgeNumberEvent, BadgeNumberState> {
  BadgeNumberBloc(super.key)
      : super(closeWithBlocKey: Keys.Blocs.noneDisposeBloc,
            initialState: const BadgeNumberInitial()) {
    on<BadgeNumberUpdated>(_onBadgeNumberUpdated);
  }

  factory BadgeNumberBloc.instance(BadgeType type) {
    final key = Keys.Blocs.badgeNumberBlocKey(type);
    return EventBus().newBlocWithConstructor<BadgeNumberBloc>(
      key,
      () => BadgeNumberBloc(key),
    );
  }

  void _onBadgeNumberUpdated(
      BadgeNumberUpdated event, Emitter<BadgeNumberState> emit) {
    emit(
      BadgeNumberUpdateSuccess(
        badgeNumber: event.badgeNumber,
      ),
    );
  }
}
