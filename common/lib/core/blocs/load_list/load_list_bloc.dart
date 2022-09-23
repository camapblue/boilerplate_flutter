import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group.dart';
import '../../models/group_list.dart';
import '../../services/load_list_service.dart';
import '../base/base_bloc.dart';

part 'load_list_event.dart';
part 'load_list_state.dart';

class LoadListBloc<T extends Object>
    extends BaseBloc<LoadListEvent, LoadListState> {
  final LoadListService<T> _loadListService;

  LoadListBloc(Key key,
      {required LoadListService<T> loadListService, Key? closeWithBlocKey})
      : _loadListService = loadListService,
        super(
          key,
          closeWithBlocKey: closeWithBlocKey,
          initialState: LoadListInitial(),
        ) {
    on<LoadListRemovedItem>(_onLoadListRemovedItem);
    on<LoadListAddedItem>(_onLoadListAddedItem);
    on<LoadListReloaded>(_onLoadListReloaded);
    on<LoadListStarted>(_onLoadListLoadedPage);
    on<LoadListRefreshed>(_onLoadListLoadedPage);
    on<LoadListNextPage>(_onLoadListLoadedPage);
  }

  void _onLoadListRemovedItem(
      LoadListRemovedItem event, Emitter<LoadListState> emit) {
    if (event.shouldUpdateList && state is LoadListLoadPageSuccess) {
      final current = state as LoadListLoadPageSuccess;
      final items = List<T>.from(current.items)..remove(event.removedItem);
      emit(
        LoadListLoadPageSuccess<T>(
          items,
          nextPage: current.nextPage,
          isFinish: current.isFinish,
          params: state.params,
        ),
      );
    } else {
      emit(LoadListRemoveItemSuccess(event.removedItem as T));
    }
  }

  void _onLoadListAddedItem(
      LoadListAddedItem event, Emitter<LoadListState> emit) {
    if (state is! LoadListLoadPageSuccess) {
      return;
    }
    final current = state as LoadListLoadPageSuccess;
    final items = List<T>.from(current.items)..add(event.addedItem as T);
    emit(
      LoadListLoadPageSuccess<T>(
        items,
        nextPage: current.nextPage,
        isFinish: current.isFinish,
        params: state.params,
      ),
    );
  }

  void _onLoadListReloaded(
      LoadListReloaded event, Emitter<LoadListState> emit) {
    if (state is! LoadListLoadPageSuccess) {
      return;
    }
    if (event.items == null) {
      add(
        LoadListRefreshed(
          params: {
            ...state.params ?? const {},
            'clearCache': true,
          },
        ),
      );
    } else {
      final current = state as LoadListLoadPageSuccess;
      emit(
        LoadListLoadPageSuccess<T>(
          event.items as List<T>,
          nextPage: current.nextPage,
          isFinish: current.isFinish,
          params: state.params,
        ),
      );
    }
  }

  Future<void> _onLoadListLoadedPage(
      LoadListEvent event, Emitter<LoadListState> emit) async {
    var items = <T>[];
    if (event is LoadListStarted) {
      emit(LoadListStartInProgress(isSilent: false));
    } else if (event is LoadListRefreshed) {
      emit(LoadListStartInProgress(isSilent: event.isSilent));
      await _loadListService.shouldRefreshItems(params: event.params ?? {});
    } else if (event is LoadListNextPage) {
      items = event.nextItems as List<T>;
    }

    try {
      var allItems = <T>[];

      final previous = state;
      var nextPage = 0;
      if (previous is LoadListLoadPageSuccess) {
        allItems = List<T>.from(previous.items);
        nextPage = previous.nextPage;
      } else {
        final params = <String, dynamic>{};
        if (event.params != null && event.params!.isNotEmpty) {
          for (final key in event.params!.keys) {
            params[key] = event.params![key];
          }
        }
        params['index'] = 0;
        items = await _loadListService.loadItems(params: params);
      }

      if (GroupList.isListGroup(items.runtimeType.toString())) {
        if (items.isEmpty) {
          emit(
            LoadListLoadPageSuccess<T>(
              allItems,
              isFinish: true,
              nextPage: nextPage,
              params: event.params,
            ),
          );
        } else {
          //ignore: avoid_as
          final groups = allItems as List<Group>..append(items as List<Group>);
          emit(
            LoadListLoadPageSuccess<Group>(
              groups,
              isFinish: false,
              nextPage: groups.totalItem(),
              params: event.params,
            ),
          );
        }
      } else {
        allItems = allItems + items;
        emit(
          LoadListLoadPageSuccess<T>(
            allItems,
            isFinish: items.isEmpty,
            nextPage: allItems.length,
            params: event.params,
          ),
        );
      }
    } catch (e) {
      emit(
        LoadListRunFailure(e.toString()),
      );
    }
  }

  void start({Map<String, dynamic>? params}) {
    if (state is LoadListInitial) {
      add(LoadListStarted(params: params));
    } else if (_loadListService.shouldReloadData(params: params ?? {})) {
      add(LoadListRefreshed(params: params));
    }
  }

  Future<List<T>> loadMore({Map<String, dynamic>? params}) async {
    final previous = state;
    if (previous is LoadListLoadPageSuccess) {
      final loadMoreParams = params ?? {};
      loadMoreParams['index'] = previous.nextPage;

      final items = await _loadListService.loadItems(params: loadMoreParams);
      return items;
    }
    return <T>[];
  }

  List<T>? getItems() {
    if (state is! LoadListLoadPageSuccess) {
      return null;
    }

    return (state as LoadListLoadPageSuccess).items as List<T>;
  }
}
