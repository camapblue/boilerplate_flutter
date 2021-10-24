import 'package:equatable/equatable.dart';

abstract class LoadListState extends Equatable {
  final Map<String, dynamic> params;

  LoadListState([this.params]);

  @override
  List<Object> get props => null;
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

  LoadListLoadPageSuccess(this.items,
      {this.nextPage = 0, this.isFinish = false, Map<String, dynamic> params})
      : super(params);

  @override
  List<Object> get props => [items, isFinish, nextPage];
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
