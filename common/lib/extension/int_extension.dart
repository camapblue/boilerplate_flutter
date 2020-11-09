import 'package:sprintf/sprintf.dart';
import 'string_extension.dart';

extension IntExtension on int {
  String toShortNumberString() {
    if (this < 10000) {
      if (this < 1000) {
        return toString();
      }
      var reverseString = toString().reverse();
      final int commaNumber = (reverseString.length - 1) ~/ 3;
      for (int i = 0; i < commaNumber; i++) {
        reverseString = reverseString.insert(',', at: (i + 1) * 3 + i);
      }
      return reverseString.reverse();
    }
    if (this < 10000000) {
      final value = this / 1000.0;
      if (value > 1000) {
        return sprintf('%0.1fk', [value]).insert(',', at: 1);
      }
      return sprintf('%0.1fk', [value]);
    }
    final value = this / 1000000.0;
    return sprintf('%0.1fm', [value]);
  }

  String toNumberString() {
    if (this < 1000) {
      return toString();
    }
    String reverseString = toString().reverse();
    final int commaNumber = (reverseString.length - 1) ~/ 3;
    for (int i = 0; i < commaNumber; i++) {
      reverseString = reverseString.insert(',', at: (i + 1) * 3 + i);
    }
    return reverseString.reverse();
  }
}
