import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static DateTime fromSeconds(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }

  static DateTime parseFacebookDateTimeString(String dateTimeString) {
    final comps = dateTimeString.split('/');
    final year = int.parse(comps[2]);
    final month = int.parse(comps[0]);
    final day = int.parse(comps[1]);

    return DateTime(year, month, day);
  }

  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;

  String toFormatString({String format = 'MMM dd yyyy'}) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  int calculateAge({DateTime? now}) {
    final currentDate = now ?? DateTime.now();
    var age = currentDate.year - year;
    final month1 = currentDate.month;
    final month2 = month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  String toTimeStringOnly() {
    return toFormatString(format: 'HH:mm');
  }

  String toWeekDayStringOnly() {
    return toFormatString(format: 'EEEE');
  }

  String toWeekDateString({String format = 'EEE, MMM dd yyyy'}) {
    if (isToday()) {
      return 'Today';
    } else if (isTomorrow()) {
      return 'Tomorrow';
    } else if (isYesterday()) {
      return 'Yesterday';
    }
    return toFormatString(format: format);
  }

  String timeInStringToNow({DateTime? now}) {
    if (isToday()) {
      return 'Today';
    } else if (isTomorrow()) {
      return 'Tomorrow';
    } else if (isYesterday()) {
      return 'Yesterday';
    }
    final nowTime = now ?? DateTime.now();
    if (nowTime.isBefore(this)) {
      return nowTime.timeInStringUpTo(this);
    }

    return nowTime.timeInStringPassedFrom(this);
  }

  int get secondsSinceEpoc => millisecondsSinceEpoch ~/ 1000;

  bool isToday() {
    final now = DateTime.now();
    final diff = now.difference(this).inDays;
    return diff == 0 && now.day == day;
  }

  bool isTheSameUTCDay({DateTime? utcDate}) {
    final target = utcDate ?? DateTime.now().toUtc();
    final diff = target.difference(toUtc()).inDays;
    return diff == 0;
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final diff = tomorrow.difference(this).inDays;
    return diff == 0 && tomorrow.day == day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().add(const Duration(days: -1));
    final diff = yesterday.difference(this).inDays;
    return diff == 0 && yesterday.day == day;
  }

  static bool isOverSevenTeen(DateTime birthday) {
    const _overAge = 17;
    final current = DateTime.now();
    final adultDate = DateTime(
      birthday.year + _overAge,
      birthday.month,
      birthday.day,
    );
    return adultDate.isBefore(current);
  }

  String timeInStringUpTo(DateTime toDate) {
    if (toDate.isBefore(this)) {
      return 'N/A';
    }

    final totalMinutes = toDate.difference(this).inMinutes;
    if (totalMinutes == 0) {
      return 'Just Now';
    }

    final upToInDays = totalMinutes ~/ (24 * 60);
    final upToInHours = (totalMinutes ~/ 60) - (upToInDays * 24);
    final upToInMinutes = totalMinutes - (upToInDays * 24) - (upToInHours * 60);

    if (upToInDays > 0) {
      return '$upToInDays days';
    } else if (upToInHours > 0) {
      return '$upToInHours hours';
    }
    return '$upToInMinutes mins';
  }

  String timeInStringPassedFrom(DateTime fromDate) {
    if (fromDate.isAfter(this)) {
      return 'N/A';
    }

    final totalMinutes = difference(fromDate).inMinutes;
    if (totalMinutes == 0) {
      return 'Just Finished';
    }

    final upToInDays = totalMinutes ~/ (24 * 60);
    final upToInHours = (totalMinutes ~/ 60) - (upToInDays * 24);
    final upToInMinutes = totalMinutes - (upToInDays * 24) - (upToInHours * 60);

    if (upToInDays > 0) {
      if (upToInDays == 1) {
        return 'A day ago';
      } else {
        if (upToInDays >= 365) {
          final yearsAgo = upToInDays ~/ 365;
          if (yearsAgo == 1) {
            return 'A year ago';
          }
          return '$yearsAgo years ago';
        } else if (upToInDays > 30) {
          final monthsAgo = upToInDays ~/ 30;
          if (monthsAgo == 1) {
            return 'A month ago';
          }
          return '$monthsAgo months ago';
        }
        return '$upToInDays days ago';
      }
    } else if (upToInHours > 0) {
      if (upToInHours == 1) {
        return 'An hour ago';
      } else {
        return '$upToInHours hours ago';
      }
    }
    return '$upToInMinutes mins ago';
  }
}
