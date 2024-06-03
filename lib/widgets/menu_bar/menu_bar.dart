import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

typedef OnItemChanged = Function(int page);
typedef MenuItemBuilder = Widget Function(int index, bool selected);

class XMenuBarController {
  void Function(int)? navigateToItem;

  void jumpTo(int index) {
    if (navigateToItem != null) {
      navigateToItem!(index);
    }
  }
}

class XMenuBar extends StatefulWidget {
  const XMenuBar({
    super.key,
    this.menuController,
    this.onItemChanged,
    required this.itemBuilder,
    required this.totalItem,
    this.itemSpacing = 0.0,
    this.height = 50,
    this.backgroundColor,
    this.hoverColor,
    this.itemBorderRadius,
    this.scrollable = true,
    this.itemEqual = false,
    this.numberRow = 1,
    this.initialIndex = 0,
    this.noSelectedItem = false,
  });

  final XMenuBarController? menuController;
  final OnItemChanged? onItemChanged;
  final MenuItemBuilder itemBuilder;
  final int totalItem;
  final double itemSpacing;
  final double height;
  final Color? backgroundColor;
  final Color? hoverColor;
  final BorderRadius? itemBorderRadius;
  final bool scrollable;
  final bool itemEqual;
  final int numberRow;
  final int initialIndex;
  final bool noSelectedItem;

  @override
  State<XMenuBar> createState() => _XMenuBarState();
}

class _XMenuBarState extends State<XMenuBar> {
  int _selectedIndex = 0;
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    
    if (widget.menuController != null) {
      widget.menuController!.navigateToItem = (int index) {
        _selectedIndex = index;

        if (widget.onItemChanged != null) {
          widget.onItemChanged!(_selectedIndex);
        }

        if (widget.scrollable) {
          itemScrollController.jumpTo(
            index: _selectedIndex,
            alignment: 0.35,
          );
        }

        setState(() {});
      };
    }

    super.initState();
  }

  Widget _buildItem(Widget item, int index, {bool isSelected = false}) {
    if (isSelected && !widget.noSelectedItem) {
      return widget.itemEqual && !widget.scrollable
          ? Expanded(
              flex: 1,
              child: item,
            )
          : item;
    }

    final menuItem = InkWell(
      onTap: () {
        if (widget.scrollable) {
          itemScrollController.scrollTo(
            index: index,
            alignment: 0.35,
            duration: const Duration(milliseconds: 250),
          );
        }
        setState(() {
          _selectedIndex = index;
        });

        if (widget.onItemChanged != null) {
          widget.onItemChanged!(index);
        }
      },
      hoverColor: widget.hoverColor,
      borderRadius: widget.itemBorderRadius,
      child: item,
    );

    return widget.itemEqual && !widget.scrollable
        ? Expanded(
            flex: 1,
            child: menuItem,
          )
        : menuItem;
  }

  List<Widget> _buildItems({int column = 0, int? itemInRow}) {
    final total = itemInRow ?? widget.totalItem;
    return List.generate(total.toInt(), (i) {
      final index = column * total + i;
      final menuItem = widget.itemBuilder(index, index == _selectedIndex);
      final item =
          _buildItem(menuItem, index, isSelected: index == _selectedIndex);
      if (widget.itemSpacing > 0) {
        return Padding(
          padding: EdgeInsets.only(right: widget.itemSpacing),
          child: item,
        );
      } else {
        return item;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.scrollable) {
      return widget.numberRow > 1
          ? Container(
              color: widget.backgroundColor,
              height: widget.height,
              child: Column(
                children: List.generate(
                  widget.numberRow,
                  (i) {
                    final itemInRow = widget.totalItem / widget.numberRow;
                    return Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Row(
                          children: _buildItems(
                            column: i,
                            itemInRow: itemInRow.toInt(),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            )
          : Container(
              color: widget.backgroundColor,
              height: widget.height,
              child: Row(
                children: _buildItems(),
              ),
            );
    }

    return Container(
      height: widget.height,
      color: widget.backgroundColor,
      child: ScrollablePositionedList.builder(
        itemCount: widget.totalItem,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final menuItem = widget.itemBuilder(index, index == _selectedIndex);
          return _buildItem(menuItem, index,
              isSelected: index == _selectedIndex);
        },
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      ),
    );
  }
}
