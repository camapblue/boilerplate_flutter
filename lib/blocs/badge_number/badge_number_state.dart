part of 'badge_number_bloc.dart';

abstract class BadgeNumberState extends Equatable {
  final int badgeNumber;

  const BadgeNumberState({this.badgeNumber = 0});

  @override
  List<Object> get props => [badgeNumber];
}

class BadgeNumberInitial extends BadgeNumberState {
  const BadgeNumberInitial() : super();
}

class BadgeNumberUpdateSuccess extends BadgeNumberState {
  const BadgeNumberUpdateSuccess({
    super.badgeNumber,
  });
}
