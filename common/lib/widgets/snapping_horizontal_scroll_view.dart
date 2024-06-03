import 'dart:math' as math;
import 'package:common/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum ItemAlignment { left, center }

typedef ItemBackgroundColor = Color Function(int index);
typedef ItemBorder = BoxBorder Function(int index);
typedef OnPageChanged = Function(int page);
typedef OnItemShouldPress = bool Function(int index);
typedef OnItemPressed = Function(int index);

class SnappingItemLayout extends StatelessWidget {
  final int index;
  final int itemCount;
  final bool edgeMargin;
  final double itemMargin;
  final double verticalMargin;
  final double itemDimension;
  final ItemAlignment alignment;
  final ItemBackgroundColor? itemColor;
  final BorderRadius? itemBorderRadius;
  final ItemBorder? itemBorder;
  final List<BoxShadow>? itemShadow;
  final IndexedWidgetBuilder itemBuilder;
  final bool isBlank;

  SnappingItemLayout({
    Key? key,
    this.index = 0,
    required this.itemCount,
    required this.edgeMargin,
    required this.itemMargin,
    required this.verticalMargin,
    required this.itemDimension,
    required this.alignment,
    this.itemColor,
    this.itemBorderRadius,
    this.itemBorder,
    this.itemShadow,
    required this.itemBuilder,
    this.isBlank = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.only(
      left: index == 0 && edgeMargin ? itemMargin : 0,
      right: edgeMargin ? itemMargin : (index < itemCount - 1 ? itemMargin : 0),
      top: verticalMargin,
      bottom: verticalMargin,
    );
    if (alignment == ItemAlignment.center) {
      final firstMargin =
          (MediaQuery.of(context).size.width - itemDimension) / 2;
      margin = EdgeInsets.only(
        left: index == 0 ? firstMargin : (itemMargin / 2),
        right: index < itemCount - 1 ? (itemMargin / 2) : firstMargin,
        top: verticalMargin,
        bottom: verticalMargin,
      );
    }

    return Container(
      width: itemDimension,
      height: double.infinity,
      decoration: isBlank
          ? null
          : BoxDecoration(
              color: itemColor != null ? itemColor!(index) : null,
              borderRadius: itemBorderRadius ?? BorderRadius.circular(8),
              border: itemBorder != null ? itemBorder!(index) : null,
              boxShadow: itemShadow ??
                  [
                    const BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2.0,
                      offset: Offset(0.5, 0.5),
                    )
                  ],
            ),
      margin: margin,
      child: itemBuilder(context, index),
    );
  }
}

class SnappingHorizontalScrollView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final double itemDimension;
  final double height;
  final int itemCount;
  final double itemMargin;
  final double verticalMargin;
  final bool edgeMargin;
  final int initialIndex;
  final ItemAlignment alignment;
  final ItemBackgroundColor? itemColor;
  final BorderRadius? itemBorderRadius;
  final ItemBorder? itemBorder;
  final List<BoxShadow>? itemShadow;
  final OnPageChanged? onPageChanged;
  final OnItemShouldPress? onItemShouldPress;
  final OnItemPressed? onItemPressed;
  final bool isBlank;

  SnappingHorizontalScrollView({
    Key? key,
    required this.itemBuilder,
    required this.itemDimension,
    required this.itemCount,
    this.height = double.infinity,
    this.itemMargin = 0,
    this.verticalMargin = 0,
    this.edgeMargin = true,
    this.initialIndex = 0,
    this.alignment = ItemAlignment.left,
    this.itemColor,
    this.itemBorderRadius,
    this.itemBorder,
    this.itemShadow,
    this.onPageChanged,
    this.onItemShouldPress,
    this.onItemPressed,
  })  : isBlank = itemColor == null &&
            itemBorderRadius == null &&
            itemBorder == null &&
            itemShadow == null,
        super(key: key);

  factory SnappingHorizontalScrollView.blank({
    required IndexedWidgetBuilder itemBuilder,
    required double itemDimension,
    required int itemCount,
    double height = double.infinity,
    double itemMargin = 0,
    double verticalMargin = 0,
    bool edgeMargin = true,
    int initialIndex = 0,
    ItemAlignment alignment = ItemAlignment.left,
    OnPageChanged? onPageChanged,
  }) {
    return SnappingHorizontalScrollView(
      itemBuilder: itemBuilder,
      itemDimension: itemDimension,
      itemCount: itemCount,
      height: height,
      itemMargin: itemMargin,
      verticalMargin: verticalMargin,
      initialIndex: initialIndex,
      alignment: alignment,
      onPageChanged: onPageChanged,
    );
  }

  @override
  _SnappingHorizontalScrollViewState createState() =>
      _SnappingHorizontalScrollViewState();
}

class _SnappingHorizontalScrollViewState
    extends State<SnappingHorizontalScrollView> {
  late ScrollController _controller;
  late ScrollPhysics _physics;

  @override
  void initState() {
    super.initState();
    final dimension = widget.itemDimension + widget.itemMargin;
    _physics = SnapScrollPhysics(itemDimension: dimension);
    _controller =
        ScrollController(initialScrollOffset: widget.initialIndex * dimension);

    if (widget.onPageChanged != null) {
      _controller.addListener(() {
        final page = _controller.offset / dimension;
        widget.onPageChanged!((page + 0.5).toInt());
      });
    }
  }

  @override
  @override
  void didUpdateWidget(SnappingHorizontalScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIndex != widget.initialIndex) {
      final dimension = widget.itemDimension + widget.itemMargin;
      _controller.animateTo(widget.initialIndex * dimension,
          duration: const Duration(milliseconds: 250), curve: Curves.linear);
    }
  }

  bool _shouldEnableToPressOnItem(int index) {
    if (widget.onItemPressed == null) {
      return false;
    }

    if (widget.onItemShouldPress == null) {
      return true;
    }

    return widget.onItemShouldPress!(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.itemCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        physics: _physics,
        itemBuilder: (context, index) => _shouldEnableToPressOnItem(index)
            ? Bounce(
                onPressed: widget.onItemPressed != null
                    ? () => widget.onItemPressed!(index)
                    : null,
                child: SnappingItemLayout(
                  index: index,
                  itemCount: widget.itemCount,
                  edgeMargin: widget.edgeMargin,
                  itemMargin: widget.itemMargin,
                  verticalMargin: widget.verticalMargin,
                  itemDimension: widget.itemDimension,
                  alignment: widget.alignment,
                  itemColor: widget.itemColor,
                  itemBorderRadius: widget.itemBorderRadius,
                  itemBorder: widget.itemBorder,
                  itemShadow: widget.itemShadow,
                  itemBuilder: widget.itemBuilder,
                  isBlank: widget.isBlank,
                ),
              )
            : SnappingItemLayout(
                index: index,
                itemCount: widget.itemCount,
                edgeMargin: widget.edgeMargin,
                itemMargin: widget.itemMargin,
                verticalMargin: widget.verticalMargin,
                itemDimension: widget.itemDimension,
                alignment: widget.alignment,
                itemColor: widget.itemColor,
                itemBorderRadius: widget.itemBorderRadius,
                itemBorder: widget.itemBorder,
                itemShadow: widget.itemShadow,
                itemBuilder: widget.itemBuilder,
                isBlank: widget.isBlank,
              ),
      ),
    );
  }
}

class SnapScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  SnapScrollPhysics({
    required this.itemDimension,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapScrollPhysics(
      itemDimension: itemDimension,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);

    //Handle scroll position when it our of portview
    if (position.outOfRange ||
        position.pixels == position.maxScrollExtent ||
        position.pixels == position.minScrollExtent) {
      double? end;
      if (position.pixels >= position.maxScrollExtent) {
        end = position.maxScrollExtent;
      }
      if (position.pixels <= position.minScrollExtent) {
        end = position.minScrollExtent;
      }

      // Check for velocity to trigger onTap event
      if (velocity.abs() < .0003 &&
          (position.pixels == position.maxScrollExtent ||
              position.pixels == position.minScrollExtent)) {
        return null;
      }

      assert(end != null, 'end must not be null');
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        end!,
        math.min(0.0, velocity),
        tolerance: tolerance,
      );
    }

    //Handle scroll position when it in portview
    //Caculate the endpoint distance
    final endPointBeforeSnappingIsCalculated =
        position.pixels + (-velocity / math.log(tolerance.time));
    var endPoint =
        (endPointBeforeSnappingIsCalculated / itemDimension).round() *
            itemDimension.toDouble();
    if (endPoint > position.maxScrollExtent) {
      endPoint = position.maxScrollExtent;
    }
    if (endPoint < position.minScrollExtent) {
      endPoint = position.minScrollExtent;
    }

    // Do nothing if the endpoint go out of portview (return null)
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      return null;
    }

    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      return null;
    }

    // Check for velocity to trigger onTap event
    if (velocity.abs() < .0003 && endPoint == position.pixels) {
      return null;
    }

    //Return scroll animation with scroll to the endpoint target.
    return ScrollSpringSimulation(spring, position.pixels, endPoint, velocity,
        tolerance: tolerance);
  }

  @override
  bool get allowImplicitScrolling => false;
}
