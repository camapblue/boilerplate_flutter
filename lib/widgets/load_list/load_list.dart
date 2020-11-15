import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/theme/theme_constants.dart';
import 'package:boilerplate_flutter/widgets/load_list/load_more_delegate.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:repository/model/model.dart';

import 'keep_alive_list_item.dart';

typedef ItemSeparatorBuilder = Widget Function(int index);

typedef ListRender<T extends Entity> = Widget Function(List<T> items);
typedef ItemBuilder<T extends Entity> = Widget Function(T item);
typedef ItemPlaceholderBuilder<T extends Entity> = Widget Function(T item);

typedef GroupHeaderBuilder = Widget Function(String headerTitle,
    {Map<String, dynamic> extraData});
typedef GroupItemBuilder<I extends Entity> = Widget Function(I item);
typedef GroupItemPlaceholderBuilder<I extends Entity> = Widget Function(I item);
typedef OnItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnDataIsReady<T extends Entity> = void Function(
    List<T> data, bool isRefreshed);

class LoadListGroupHeader extends StatelessWidget {
  final List<Group> groups;
  final int index;
  final GroupHeaderBuilder builder;

  LoadListGroupHeader({
    this.groups,
    this.index,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isHidden = groups.isGroupHeaderHidden(index: index);
    if (isHidden) {
      return const SizedBox();
    }

    return builder(
      groups.groupHeaderTitle(index: index),
      extraData: groups.groupHeaderExtraData(index: index),
    );
  }
}

class ListItemLayout extends StatefulWidget {
  final Widget child;
  final Widget placeholder;
  final Duration duration;
  final bool slideUpAnimation;

  ListItemLayout({
    this.placeholder,
    @override this.child,
    this.duration = const Duration(milliseconds: 350),
    this.slideUpAnimation = false,
  });

  @override
  State<ListItemLayout> createState() {
    return _ListItemLayout();
  }
}

class _ListItemLayout extends State<ListItemLayout>
    with SingleTickerProviderStateMixin {
  AnimationController _animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_animation != null) {
        await Future.delayed(const Duration(milliseconds: 350));
        _animation.forward();
      }
    });

    setUpSlideAnimationIfNeeded();
  }

  void setUpSlideAnimationIfNeeded() {
    if (!widget.slideUpAnimation) {
      return;
    }

    _animation = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void dispose() {
    if (_animation != null) {
      _animation.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slideUpAnimation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animation,
            curve: Curves.easeInCubic,
          ),
        ),
        child: widget.child,
      );
    }

    return FadingWithPlaceholder(
      placeholder: widget.placeholder,
      child: widget.child,
    );
  }
}

class LoadList<T extends Entity> extends StatefulWidget {
  LoadList({
    @required this.blocKey,
    this.emptyMessage,
    this.listRender,
    this.itemBuilder,
    this.onItemRemoved,
    this.itemSeparatorBuilder,
    this.itemPlaceholderBuilder,
    this.groupItemBuilder,
    this.groupItemPlaceholderBuilder,
    this.groupHeaderBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.loadingIndicatorColor = whiteColor,
    this.onDataIsReady,
    this.onShouldRefresh,
    this.padding = const EdgeInsets.all(8),
    this.slideUpAnimation = false,
    this.startingSlideUpIndex = 3,
    this.needLoadMore = true,
    this.autoStart = true,
    this.supportFlatGroup = false,
    this.automaticKeepAlives = false,
    this.params,
  })  : assert(
            listRender != null ||
                itemBuilder != null ||
                supportFlatGroup == true,
            'Must provide at least one render.'),
        assert(emptyWidget != null || emptyMessage != null,
            'Must provide at least one empty case.');

  final Key blocKey;
  final String emptyMessage;
  final ListRender<T> listRender;
  final ItemBuilder<T> itemBuilder;
  final OnItemRemoved<T> onItemRemoved;
  final ItemSeparatorBuilder itemSeparatorBuilder;
  final ItemPlaceholderBuilder<T> itemPlaceholderBuilder;

  final GroupItemBuilder groupItemBuilder;
  final GroupItemPlaceholderBuilder groupItemPlaceholderBuilder;
  final GroupHeaderBuilder groupHeaderBuilder;

  final OnDataIsReady<T> onDataIsReady;
  final Widget emptyWidget;
  final Widget loadingWidget;
  final Color loadingIndicatorColor;
  final Function onShouldRefresh;
  final EdgeInsets padding;
  final bool slideUpAnimation;
  final int startingSlideUpIndex;
  final bool needLoadMore;
  final bool autoStart;
  final bool supportFlatGroup;
  final bool automaticKeepAlives;
  final Map<String, dynamic> params;

  @override
  State<StatefulWidget> createState() {
    return _LoadListState<T>();
  }
}

class _LoadListState<T extends Entity> extends State<LoadList<T>> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  LoadMoreDelegate _loadMoreDelegate;
  bool _isRefresh = false;
  final _scrollController = ScrollController();
  double _previousScrollPosition = 0.0;
  bool _isScrollDown = true;

  @override
  void initState() {
    super.initState();

    if (widget.listRender == null) {
      _loadMoreDelegate = ListViewLoadMoreDelegate();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //ignore: close_sinks
      final loadListBloc =
          EventBus().blocFromKey<LoadListBloc<T>>(widget.blocKey);
      if (loadListBloc != null) {
        final state = loadListBloc.state;
        if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
          widget.onDataIsReady(state.items, _isRefresh);
        } else if (state is LoadListInitial && widget.autoStart) {
          loadListBloc.start();
        }
      }
    });

    _scrollController.addListener(() {
      _isScrollDown =
          _scrollController.position.pixels > _previousScrollPosition;
      _previousScrollPosition = _scrollController.position.pixels;
    });
  }

  void _reload() {
    EventBus().event<LoadListBloc>(
      widget.blocKey,
      LoadListRefreshed(params: widget.params),
    );
  }

  Future<void> _refresh() async {
    if (widget.onShouldRefresh != null) {
      widget.onShouldRefresh();
    }
    _isRefresh = true;
    EventBus().event<LoadListBloc>(
      widget.blocKey,
      LoadListRefreshed(params: widget.params),
    );
  }

  Widget _buildLoadList(List<Object> items) {
    Widget listView;
    if (widget.listRender == null) {
      if (widget.supportFlatGroup) {
        assert(
            widget.groupItemBuilder != null &&
                widget.groupHeaderBuilder != null,
            '''Must provide builder for group item in case support flat group''');

        final List<Group> groups = items;

        if (widget.itemSeparatorBuilder != null) {
          listView = ListView.separated(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: groups.totalItemWithHeader(),
            separatorBuilder: (_, index) => widget.itemSeparatorBuilder(index),
            itemBuilder: (_, index) {
              if (groups.isGroupHeader(index: index)) {
                return LoadListGroupHeader(
                  groups: groups,
                  index: index,
                  builder: widget.groupHeaderBuilder,
                );
              }
              final item = groups.groupItem(index: index);
              return widget.groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      placeholder: widget.groupItemPlaceholderBuilder(item),
                      slideUpAnimation: widget.slideUpAnimation &&
                          _isScrollDown &&
                          index >= widget.startingSlideUpIndex,
                      child: widget.groupItemBuilder(item),
                    )
                  : widget.groupItemBuilder(item);
            },
          );
        } else {
          listView = ListView.builder(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: groups.totalItemWithHeader(),
            itemBuilder: (_, index) {
              if (groups.isGroupHeader(index: index)) {
                return LoadListGroupHeader(
                  groups: groups,
                  index: index,
                  builder: widget.groupHeaderBuilder,
                );
              }
              final item = groups.groupItem(index: index);
              return widget.groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      placeholder: widget.groupItemPlaceholderBuilder(item),
                      slideUpAnimation: widget.slideUpAnimation &&
                          _isScrollDown &&
                          index >= widget.startingSlideUpIndex,
                      child: widget.groupItemBuilder(item),
                    )
                  : widget.groupItemBuilder(item);
            },
          );
        }
      } else {
        if (widget.itemSeparatorBuilder != null) {
          listView = ListView.separated(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: items.length,
            separatorBuilder: (_, index) => widget.itemSeparatorBuilder(index),
            addAutomaticKeepAlives: widget.automaticKeepAlives,
            itemBuilder: (_, index) => widget.itemPlaceholderBuilder != null
                ? ListItemLayout(
                    placeholder: widget.itemPlaceholderBuilder(items[index]),
                    child: widget.itemBuilder(items[index]),
                  )
                : KeepAliveListItem(
                    automaticKeepAlive: widget.automaticKeepAlives,
                    child: widget.itemBuilder(items[index]),
                  ),
          );
        } else {
          listView = ListView.builder(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: items.length,
            addAutomaticKeepAlives: widget.automaticKeepAlives,
            itemBuilder: (_, index) => widget.itemPlaceholderBuilder != null
                ? ListItemLayout(
                    placeholder: widget.itemPlaceholderBuilder(items[index]),
                    child: widget.itemBuilder(items[index]),
                  )
                : KeepAliveListItem(
                    automaticKeepAlive: widget.automaticKeepAlives,
                    child: widget.itemBuilder(items[index]),
                  ),
          );
        }
      }
    }
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadListBloc<T>, LoadListState>(
      listenWhen: (previous, current) =>
          current is LoadListLoadPageSuccess ||
          current is LoadListRemoveItemSuccess,
      listener: (context, state) {
        if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
          widget.onDataIsReady(state.items, _isRefresh);
          _isRefresh = false;
        } else if (state is LoadListRemoveItemSuccess &&
            widget.onItemRemoved != null) {
          widget.onItemRemoved(state.removedItem);
        }
      },
      buildWhen: (previous, current) => current is! LoadListRemoveItemSuccess,
      builder: (context, state) {
        if (state is LoadListStartInProgress || state is LoadListInitial) {
          return widget.loadingWidget ??
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.loadingIndicatorColor),
                ),
              );
        }
        if (state is LoadListRunFailure) {
          return ErrorList(
            errorMessage: state.errorMessage,
            doReload: _reload,
          );
        }

        if (state is LoadListLoadPageSuccess) {
          final listView = _buildLoadList(state.items);

          return state.items.isEmpty
              ? widget.emptyWidget ??
                  EmptyList(
                    emptyMessage: widget.emptyMessage,
                    doReload: _reload,
                    color: widget.loadingIndicatorColor,
                  )
              : widget.listRender != null
                  ? widget.listRender(state.items)
                  : RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                      child: widget.needLoadMore
                          ? LoadMore(
                              delegate: _loadMoreDelegate,
                              isFinish: state.isFinish,
                              onLoadMore: () async {
                                //ignore: close_sinks
                                final loadListBloc = EventBus()
                                    .blocFromKey<LoadListBloc<T>>(
                                        widget.blocKey);
                                if (loadListBloc == null) {
                                  return false;
                                }
                                final nextItems = await loadListBloc.loadMore(
                                    params: widget.params);
                                if (nextItems.isEmpty) {
                                  return false;
                                }
                                EventBus().event<LoadListBloc>(
                                  widget.blocKey,
                                  LoadListNextPage<T>(nextItems: nextItems),
                                );
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                return true;
                              },
                              child: listView,
                            )
                          : listView,
                    );
        }

        return Container();
      },
    );
  }
}
