import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';

import '../../blocs/blocs.dart';
import '../../models/group.dart';
import '../../models/group_list.dart';
import '../fading_with_placeholder/fading_with_placeholder.dart';
import 'empty_list.dart';
import 'error_list.dart';
import 'keep_alive_list_item.dart';
import 'load_more_delegate.dart';

typedef ItemSeparatorBuilder = Widget Function(int index);

typedef ListRender<T extends Object> = Widget Function(List<T> items);
typedef ItemBuilder<T extends Object> = Widget Function(T item, int index);
typedef ItemPlaceholderBuilder<T extends Object> = Widget Function(T item);

typedef GroupHeaderBuilder = Widget Function(String headerTitle,
    {Map<String, dynamic>? extraData});
typedef GroupItemBuilder<I extends Object> = Widget Function(I item);
typedef GroupItemPlaceholderBuilder<I extends Object> = Widget Function(I item);
typedef OnItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnDataIsReady<T extends Object> = void Function(
    List<T> data, bool isRefreshed);

class LoadListGroupHeader extends StatelessWidget {
  final List<Group> groups;
  final int index;
  final GroupHeaderBuilder builder;

  const LoadListGroupHeader({
    Key? key,
    required this.groups,
    required this.index,
    required this.builder,
  }) : super(key: key);

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
  final Widget? placeholder;
  final Duration duration;
  final bool slideUpAnimation;

  const ListItemLayout({
    Key? key,
    this.placeholder,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.slideUpAnimation = false,
  }) : super(key: key);

  @override
  State<ListItemLayout> createState() {
    return _ListItemLayout();
  }
}

class _ListItemLayout extends State<ListItemLayout>
    with SingleTickerProviderStateMixin {
  AnimationController? _animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_animation != null) {
        await Future.delayed(const Duration(milliseconds: 350));
        await _animation?.forward();
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
      _animation?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slideUpAnimation && _animation != null) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animation!,
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

class LoadList<T extends Object> extends StatefulWidget {
  const LoadList({
    Key? key,
    required this.blocKey,
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
    this.errorWidget,
    this.loadingWidget,
    this.loadingIndicatorColor = Colors.white,
    this.onDataIsReady,
    this.onShouldRefresh,
    this.padding = EdgeInsets.zero,
    this.slideUpAnimation = false,
    this.startingSlideUpIndex = 3,
    this.needLoadMore = true,
    this.needPullToRefresh = true,
    this.autoStart = true,
    this.supportFlatGroup = false,
    this.automaticKeepAlives = false,
    this.params,
    this.itemFilter,
    this.sort,
    this.scrollbarEnabled = true,
    this.needReloadWhenEmpty = false,
  })  : assert(
            listRender != null ||
                itemBuilder != null ||
                supportFlatGroup == true,
            'Must provide at least one render.'),
        assert(emptyWidget != null || emptyMessage != null,
            'Must provide at least one empty case.'),
        super(key: key);

  final Key blocKey;
  final String? emptyMessage;
  final ListRender<T>? listRender;
  final ItemBuilder<T>? itemBuilder;
  final OnItemRemoved<T>? onItemRemoved;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;

  final GroupItemBuilder? groupItemBuilder;
  final GroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;
  final GroupHeaderBuilder? groupHeaderBuilder;

  final OnDataIsReady<T>? onDataIsReady;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Color loadingIndicatorColor;
  final Function? onShouldRefresh;
  final EdgeInsets padding;
  final bool slideUpAnimation;
  final int startingSlideUpIndex;
  final bool needLoadMore;
  final bool needPullToRefresh;
  final bool autoStart;
  final bool supportFlatGroup;
  final bool automaticKeepAlives;
  final Map<String, dynamic>? params;
  final bool Function(T)? itemFilter;
  final int Function(T a, T b)? sort;
  final bool scrollbarEnabled;
  final bool needReloadWhenEmpty;

  @override
  State<StatefulWidget> createState() {
    return _LoadListState<T>();
  }
}

class _LoadListState<T extends Object> extends State<LoadList<T>> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  LoadMoreDelegate? _loadMoreDelegate;
  bool _isRefresh = false;
  final _scrollController = ScrollController();
  double _previousScrollPosition = 0.0;
  bool _isScrollDown = true;

  List<T> getItems(LoadListState state) {
    if (state is LoadListLoadPageSuccess) {
      var items = state.items as List<T>;

      if (widget.itemFilter != null) {
        items = items.where((element) => widget.itemFilter!(element)).toList();
      }

      if (widget.sort != null) {
        items.sort(widget.sort);
      }

      return items;
    }

    return [];
  }

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
          widget.onDataIsReady!(state.items as List<T>, _isRefresh);
        } else if (state is LoadListInitial && widget.autoStart) {
          loadListBloc.start(params: widget.params);
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
      widget.onShouldRefresh!();
    }
    _isRefresh = true;
    EventBus().event<LoadListBloc>(
      widget.blocKey,
      LoadListRefreshed(params: widget.params),
    );
  }

  Widget _buildLoadList(List<Object> items) {
    Widget listView = const SizedBox();
    if (widget.listRender == null) {
      if (widget.supportFlatGroup) {
        assert(
            widget.groupItemBuilder != null &&
                widget.groupHeaderBuilder != null,
            '''Must provide builder for group item in case support flat group''');

        final groups = items as List<Group>;

        if (widget.itemSeparatorBuilder != null) {
          listView = ListView.separated(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: groups.totalItemWithHeader(),
            separatorBuilder: (_, index) => widget.itemSeparatorBuilder!(index),
            itemBuilder: (_, index) {
              if (groups.isGroupHeader(index: index)) {
                return LoadListGroupHeader(
                  groups: groups,
                  index: index,
                  builder: widget.groupHeaderBuilder!,
                );
              }
              final item = groups.groupItem(index: index);
              if (item == null) {
                return const SizedBox();
              }
              return widget.groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      placeholder: widget.groupItemPlaceholderBuilder!(item),
                      slideUpAnimation: widget.slideUpAnimation &&
                          _isScrollDown &&
                          index >= widget.startingSlideUpIndex,
                      child: widget.groupItemBuilder!(item),
                    )
                  : widget.groupItemBuilder!(item);
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
                  builder: widget.groupHeaderBuilder!,
                );
              }
              final item = groups.groupItem(index: index);
              return widget.groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      placeholder: widget.groupItemPlaceholderBuilder!(item!),
                      slideUpAnimation: widget.slideUpAnimation &&
                          _isScrollDown &&
                          index >= widget.startingSlideUpIndex,
                      child: widget.groupItemBuilder!(item),
                    )
                  : widget.groupItemBuilder!(item!);
            },
          );
        }
      } else {
        if (widget.itemSeparatorBuilder != null) {
          listView = ListView.separated(
            controller: _scrollController,
            padding: widget.padding,
            itemCount: items.length,
            separatorBuilder: (_, index) => widget.itemSeparatorBuilder!(index),
            addAutomaticKeepAlives: widget.automaticKeepAlives,
            itemBuilder: (_, index) => widget.itemPlaceholderBuilder != null
                ? ListItemLayout(
                    placeholder:
                        widget.itemPlaceholderBuilder!(items[index] as T),
                    child: widget.itemBuilder!(items[index] as T, index),
                  )
                : KeepAliveListItem(
                    automaticKeepAlive: widget.automaticKeepAlives,
                    child: widget.itemBuilder!(items[index] as T, index),
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
                    placeholder:
                        widget.itemPlaceholderBuilder!(items[index] as T),
                    child: widget.itemBuilder!(items[index] as T, index),
                  )
                : KeepAliveListItem(
                    automaticKeepAlive: widget.automaticKeepAlives,
                    child: widget.itemBuilder!(items[index] as T, index),
                  ),
          );
        }
      }
    }
    return widget.scrollbarEnabled ? Scrollbar(child: listView) : listView;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadListBloc<T>, LoadListState>(
      bloc: EventBus().blocFromKey<LoadListBloc<T>>(widget.blocKey),
      listenWhen: (previous, current) =>
          current is LoadListLoadPageSuccess ||
          current is LoadListRemoveItemSuccess,
      listener: (context, state) {
        if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
          widget.onDataIsReady!(state.items as List<T>, _isRefresh);
          _isRefresh = false;
        } else if (state is LoadListRemoveItemSuccess &&
            widget.onItemRemoved != null) {
          widget.onItemRemoved!(state.removedItem as T);
        }
      },
      buildWhen: (previous, current) {
        if (current is LoadListRemoveItemSuccess) {
          return false;
        }

        if (current is LoadListStartInProgress) {
          return !current.isSilent;
        }

        return true;
      },
      builder: (context, state) {
        if (state is LoadListStartInProgress) {
          return widget.loadingWidget ??
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.loadingIndicatorColor),
                ),
              );
        }

        if (state is LoadListRunFailure) {
          return widget.errorWidget ??
              ErrorList(errorMessage: state.errorMessage, doReload: _reload);
        }

        if (state is LoadListLoadPageSuccess) {
          final items = getItems(state);

          final listView = _buildLoadList(items);

          return items.isEmpty
              ? widget.emptyWidget ??
                  EmptyList(
                    emptyMessage: widget.emptyMessage ?? 'No Items',
                    color: widget.loadingIndicatorColor,
                    onReload: widget.needReloadWhenEmpty ? _reload : null,
                  )
              : widget.listRender != null
                  ? widget.listRender!(items)
                  : widget.needPullToRefresh
                      ? RefreshIndicator(
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
                                    final nextItems = await loadListBloc
                                        .loadMore(params: widget.params);
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
                        )
                      : listView;
        }

        return const SizedBox();
      },
    );
  }
}
