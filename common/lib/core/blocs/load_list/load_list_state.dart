part of 'load_list_bloc.dart';

abstract class LoadListState extends Equatable {
  final Map<String, dynamic>? params;
  final DateTime lastUpdated;

  LoadListState([this.params]) : lastUpdated = DateTime.now();

  @override
  List<Object> get props => [lastUpdated];
}

class LoadListInitial extends LoadListState {}

class LoadListStartInProgress extends LoadListState {
  final bool isSilent;
  LoadListStartInProgress({this.isSilent = false});
}

class LoadListLoadPageSuccess<T extends Object> extends LoadListState {
  final List<T> items;
  final int nextPage;
  final bool isFinish;

  LoadListLoadPageSuccess(
    this.items, {
    this.nextPage = 0,
    this.isFinish = false,
    Map<String, dynamic>? params,
  }) : super(params);

  @override
  List<Object> get props => [items, isFinish, nextPage, lastUpdated];
}

class LoadListRunFailure extends LoadListState {
  final String errorMessage;

  LoadListRunFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoadListRemoveItemSuccess<T extends Object> extends LoadListState {
  final T removedItem;

  LoadListRemoveItemSuccess(this.removedItem);

  @override
  List<Object> get props => [removedItem];
}
