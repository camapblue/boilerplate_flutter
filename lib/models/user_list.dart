import 'package:boilerplate_flutter/models/models.dart';
import 'package:common/core/core.dart';
import 'package:repository/repository.dart';

extension ListUser on List<User> {
  List<Group<User>> groupByOccupation() {
    if (isEmpty) {
      return <Group<User>>[];
    }

    sort((a, b) => a.compareByOccupation(b));

    final groups = <Group<User>>[];
    var currentGroup = Group<User>(groupBy: first.job);

    for (final user in this) {
      if (user.job.compareTo(currentGroup.groupBy) == 0) {
        currentGroup.add(user);
      } else {
        groups.add(currentGroup);
        currentGroup = Group<User>(groupBy: user.job)..add(user);
      }
    }
    groups.add(currentGroup);
    return groups;
  }
}
