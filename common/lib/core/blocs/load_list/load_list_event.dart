part of 'load_list_bloc.dart';

abstract class LoadListEvent {
  final Map<String, dynamic>? params;

  const LoadListEvent([this.params]);
}

class LoadListStarted extends LoadListEvent {
  const LoadListStarted({Map<String, dynamic>? params}) : super(params);
}

class LoadListNextPage<T extends Object> extends LoadListEvent {
  final List<T> nextItems;

  const LoadListNextPage({required this.nextItems}) : super();
}

class LoadListRefreshed extends LoadListEvent {
  final bool isSilent;
  LoadListRefreshed({
    Map<String, dynamic>? params,
    this.isSilent = false,
  }) : super(params);
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

class LoadListReloaded<T extends Object> extends LoadListEvent {
  final List<T>? items;

  const LoadListReloaded({this.items}) : super();
}
