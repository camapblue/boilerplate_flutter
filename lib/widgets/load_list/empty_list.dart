import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/theme/theme_constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'load_list_theme.dart';

class EmptyList extends StatelessWidget {
  EmptyList({
    Key key,
    @required this.emptyMessage,
    @required this.doReload,
    this.color = whiteColor,
  }) : super(key: key);

  final Function doReload;
  final String emptyMessage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            height: 64,
            child: Center(
              child: AppIcon(
                icon: AppIcons.empty,
                width: 92,
                height: 92,
                color: color,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .loadListEmptyMessageTextStyle
                  .copyWith(color: color),
            ),
          ),
          Button.reload(context: context, onPressed: doReload),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
