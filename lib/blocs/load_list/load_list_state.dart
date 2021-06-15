import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:repository/model/model.dart';

abstract class LoadListState extends Equatable {
  @override
  List<Object> get props => null;
}

class LoadListInitial extends LoadListState {}

class LoadListStartInProgress extends LoadListState {
  final bool isSilent;
  LoadListStartInProgress({@required this.isSilent});
}

class LoadListLoadPageSuccess<T extends Entity> extends LoadListState {
  final List<T> items;
  final int nextPage;
  final bool isFinish;

  LoadListLoadPageSuccess(this.items,
      {this.nextPage = 0, this.isFinish = false});

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