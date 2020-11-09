import 'package:flutter/foundation.dart';

extension StringExtension on String {
  String reverse() {
    return split('').reversed.join();
  }

  String insert(String string, {@required int at}) {
    final comps = List<String>.from(split(''))..insert(at, string);
    return comps.join();
  }

  String excludePrefixURLIfNeeded() {
    if (!isURL()) {
      return this;
    }

    final Uri uri = Uri.parse(this);
    return uri.path;
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension StringValidator on String {
  bool isURL() {
    const pattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  bool isEmail() {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  bool isNumber() {
    return int.tryParse(this) != null;
  }
}
