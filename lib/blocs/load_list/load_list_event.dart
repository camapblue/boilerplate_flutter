import 'package:repository/model/model.dart';

abstract class LoadListEvent {
  final Map<String, dynamic> params;

  const LoadListEvent([this.params]);
}

class LoadListStarted extends LoadListEvent {
  const LoadListStarted({Map<String, dynamic> params}) : super(params);
}

class LoadListNextPage<T extends Entity> extends LoadListEvent {
  final List<T> nextItems;

  const LoadListNextPage({this.nextItems}) : super();
}

class LoadListRefreshed extends LoadListEvent {
  final bool isSilent;
  const LoadListRefreshed({Map<String, dynamic> params, this.isSilent = false})
      : super(params);
}

class LoadListRemovedItem<T extends Object> extends LoadListEvent {
  final T removedItem;
  final bool shouldUpdateList;

  const LoadListRemovedItem(this.removedItem, {this.shouldUpdateList = false})
      : super();
}

class LoadListAddedItem<T extends Object> extends LoadListEvent {
  final T addedItem;

  const LoadListAddedItem(this.addedItem) : super();
}

class LoadListReloaded<T extends Entity> extends LoadListEvent {
  final List<T> items;

  const LoadListReloaded({this.items}) : super();
}
