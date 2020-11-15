import 'package:repository/repository.dart';
import 'package:common/extension/date_time_extension.dart';

extension UserExtension on User {
  int compareByOccupation(User b) {
    return occupation.compareTo(b.occupation);
  }

  int get age => birthday.calculateAge();
}