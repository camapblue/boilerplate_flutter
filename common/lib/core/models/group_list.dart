import 'group.dart';

extension GroupList on List<Group> {
  static bool isListGroup(String type) => type.contains('List<Group<');

  int totalItem() {
    var total = 0;
    for (final group in this) {
      if (isListGroup(group.list.runtimeType.toString())) {
        //ignore: avoid_as
        total += GroupList(group.list as List<Group>).totalItem();
      } else {
        total += group.length;
      }
    }
    return total;
  }

  int totalItemWithHeader() {
    var total = 0;
    for (final group in this) {
      total += group.length;
      total += 1; // group header
    }
    return total;
  }

  bool isGroupHeader({required int index}) {
    if (index == 0) {
      return true;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return true;
      } else if (headerIndex > index) {
        break;
      }
    }
    return false;
  }

  String groupHeaderTitle({required int index}) {
    if (index == 0) {
      return first.groupBy;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].groupBy;
      } else if (headerIndex > index) {
        break;
      }
    }
    return 'N/A';
  }

  bool isGroupHeaderHidden({required int index}) {
    if (index == 0) {
      return first.isHidden;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].isHidden;
      } else if (headerIndex > index) {
        break;
      }
    }
    return false;
  }

  Map<String, dynamic> groupHeaderExtraData({required int index}) {
    if (index == 0) {
      return first.extra ?? {};
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].extra ?? {};
      } else if (headerIndex > index) {
        break;
      }
    }
    return const {};
  }

  I? groupItem<I extends Object>({required int index}) {
    if (index == 0) {
      return null;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      final previousIndex = headerIndex;
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return null;
      } else if (headerIndex > index) {
        return this[i].itemAtIndex(index - previousIndex - 1) as I;
      }
    }
    return null;
  }

  void append(List<Group> groups) {
    if (groups.isEmpty) {
      return;
    }
    if (isEmpty) {
      addAll(groups);
      return;
    }

    if (this[length - 1].groupBy == groups.first.groupBy) {
      this[length - 1].addAll(groups.first.list);
      addAll(groups.sublist(1, groups.length));
    } else {
      addAll(groups);
    }
  }
}
