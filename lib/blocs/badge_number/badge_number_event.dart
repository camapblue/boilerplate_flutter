part of 'badge_number_bloc.dart';

abstract class BadgeNumberEvent {
  const BadgeNumberEvent();
}

class BadgeNumberUpdated extends BadgeNumberEvent {
  final int badgeNumber;

  BadgeNumberUpdated({
    required this.badgeNumber,
  });
}
