import 'package:common/common.dart';
import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/blocs/base/base_bloc.dart';
import 'package:repository/model/model.dart';
import 'package:repository/repository.dart';

import 'load_list.dart';

class LoadListBloc<T extends Entity>
    extends BaseBloc<LoadListEvent, LoadListState> {
  final LoadListService<T> _loadListService;

  LoadListBloc(Key key,
      {@required LoadListService<T> loadListService, Key closeWithBlocKey})
      : _loadListService = loadListService,
        super(
          key,
          closeWithBlocKey: closeWithBlocKey,
          initialState: LoadListInitial(),
        );

  @override
  Stream<LoadListState> mapEventToState(LoadListEvent event) async* {
    if (event is LoadListRemovedItem) {
      if (event.shouldUpdateList && state is LoadListLoadPageSuccess) {
        final LoadListLoadPageSuccess current = state;
        final items = List<T>.from(current.items)..remove(event.removedItem);
        yield LoadListLoadPageSuccess<T>(
          items,
          nextPage: current.nextPage,
          isFinish: current.isFinish,
          params: state.params,
        );
      } else {
        yield LoadListRemoveItemSuccess(event.removedItem);
      }
    } else if (event is LoadListAddedItem) {
      final LoadListLoadPageSuccess current = state;
      final items = List<T>.from(current.items)..add(event.addedItem);
      yield LoadListLoadPageSuccess<T>(
        items,
        nextPage: current.nextPage,
        isFinish: current.isFinish,
        params: state.params,
      );
    } else if (event is LoadListReloaded && state is LoadListLoadPageSuccess) {
      if (event.items == null) {
        add(LoadListRefreshed(params: {
          ...state.params,
          'clearCache': true,
        }));
      } else {
        final LoadListLoadPageSuccess current = state;
        yield LoadListLoadPageSuccess<T>(
          event.items,
          nextPage: current.nextPage,
          isFinish: current.isFinish,
          params: state.params,
        );
      }
    } else {
      yield* _mapLoadListLoadedPageToState(event);
    }
  }

  Stream<LoadListState> _mapLoadListLoadedPageToState(
      LoadListEvent event) async* {
    var items = <T>[];
    if (event is LoadListStarted) {
      yield LoadListStartInProgress(isSilent: false);
    } else if (event is LoadListRefreshed) {
      yield LoadListStartInProgress(isSilent: event.isSilent);
      await _loadListService.shouldRefreshItems(params: event.params);
    } else if (event is LoadListNextPage) {
      items = event.nextItems;
    }

    try {
      var allItems = <T>[];

      final previous = state;
      var nextPage = 0;
      if (previous is LoadListLoadPageSuccess) {
        allItems = List<T>.from(previous.items);
        nextPage = previous.nextPage;
      } else {
        final params = event.params != null
            ? Map<String, dynamic>.from(event.params)
            : <String, dynamic>{};
        params['index'] = 0;
        items = await _loadListService.loadItems(params: params);
      }

      if (GroupList.isListGroup(items.runtimeType.toString())) {
        if (items.isEmpty) {
          yield LoadListLoadPageSuccess<T>(
            allItems,
            isFinish: true,
            nextPage: nextPage,
            params: event.params,
          );
        } else {
          //ignore: avoid_as
          final groups = allItems as List<Group>..append(items as List<Group>);
          yield LoadListLoadPageSuccess<Group>(
            groups,
            isFinish: false,
            nextPage: groups.totalItem(),
            params: event.params,
          );
        }
      } else {
        allItems = allItems + items;
        yield LoadListLoadPageSuccess<T>(
          allItems,
          isFinish: items.isEmpty,
          nextPage: allItems.length,
          params: event.params,
        );
      }
    } catch (e) {
      log.error('Load List Error >> $e');
      yield LoadListRunFailure(e.toString());
    }
  }

  void start({Map<String, dynamic> params, bool shouldReload = false}) {
    if (state is LoadListInitial) {
      add(LoadListStarted(params: params));
    } else if (shouldReload) {
      add(const LoadListReloaded());
    } else if (_loadListService.shouldReloadData(params: params)) {
      add(LoadListRefreshed(params: params));
    }
  }

  Future<List<T>> loadMore({Map<String, dynamic> params}) async {
    final previous = state;
    if (previous is LoadListLoadPageSuccess) {
      final loadMoreParams = params ?? {};
      loadMoreParams['index'] = previous.nextPage;

      final items = await _loadListService.loadItems(params: loadMoreParams);
      return items;
    }
    return <T>[];
  }

  List<T> getCurrentItems() {
    if (state is LoadListLoadPageSuccess) {
      return (state as LoadListLoadPageSuccess).items;
    }

    return null;
  }
}
