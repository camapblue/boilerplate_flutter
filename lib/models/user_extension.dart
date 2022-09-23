import 'package:repository/repository.dart';
import 'package:common/extension/date_time_extension.dart';

extension UserExtension on User {
  String get job => occupation ?? 'No Job';

  int compareByOccupation(User b) {
    return job.compareTo(b.job);
  }

  int? get age => birthday?.calculateAge();
}