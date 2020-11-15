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
  const LoadListRefreshed({Map<String, dynamic> params}) : super(params);
}

class LoadListRemovedItem<T extends Object> extends LoadListEvent {
  final T removedItem;

  const LoadListRemovedItem(this.removedItem) : super();
}
