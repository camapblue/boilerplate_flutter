import 'package:flutter/material.dart';

class KeepAliveListItem extends StatefulWidget {
  final Widget child;
  final bool automaticKeepAlive;

  const KeepAliveListItem({
    Key? key,
    required this.child,
    this.automaticKeepAlive = false,
  }) : super(key: key);

  @override
  State<KeepAliveListItem> createState() {
    return _KeepAliveListItemState();
  }
}

class _KeepAliveListItemState extends State<KeepAliveListItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.automaticKeepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
