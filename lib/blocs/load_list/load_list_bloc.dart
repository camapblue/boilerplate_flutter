import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:boilerplate_flutter/services/services.dart';
import 'package:common/common.dart';
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
          initialState: LoadListInitial(),
          closeWithBlocKey: closeWithBlocKey,
        );

  @override
  Stream<LoadListState> mapEventToState(LoadListEvent event) async* {
    if (event is LoadListRemovedItem) {
      yield LoadListRemoveItemSuccess(event.removedItem);
    } else if (event is LoadListAddedItem) {
      final LoadListLoadPageSuccess current = state;
      final items = List<T>.from(current.items)..add(event.addedItem);
      yield LoadListLoadPageSuccess<T>(items,
          nextPage: current.nextPage, isFinish: current.isFinish);
    } else if (event is LoadListReloaded && state is LoadListLoadPageSuccess) {
      final LoadListLoadPageSuccess current = state;
      yield LoadListLoadPageSuccess<T>(event.items,
          nextPage: current.nextPage, isFinish: current.isFinish);
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

      EventBus().cleanUp(parentKey: key);
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
        final params = event.params ?? {};
        params['index'] = 0;

        items = await _loadListService.loadItems(params: params);
      }

      if (GroupList.isListGroup(items.runtimeType.toString())) {
        if (items.isEmpty) {
          yield LoadListLoadPageSuccess<T>(allItems,
              isFinish: true, nextPage: nextPage);
        } else {
          //ignore: avoid_as
          final groups = allItems as List<Group>..append(items as List<Group>);
          yield LoadListLoadPageSuccess<Group>(groups,
              isFinish: false, nextPage: groups.totalItem());
        }
      } else {
        allItems = allItems + items;
        yield LoadListLoadPageSuccess<T>(allItems,
            isFinish: items.isEmpty, nextPage: allItems.length);
      }
    } catch (e) {
      log.error('Load List Error >> $e');
      yield LoadListRunFailure(e.toString());
    }
  }

  void start({Map<String, dynamic> params}) {
    if (state is LoadListInitial) {
      addLater(
        LoadListStarted(params: params),
        after: const Duration(seconds: 1),
      );
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
}
