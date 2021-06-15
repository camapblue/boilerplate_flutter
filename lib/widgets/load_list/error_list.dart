import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';

import 'load_list_theme.dart';

class ErrorList extends StatelessWidget {
  ErrorList({Key key, @required this.errorMessage, @required this.doReload})
      : super(key: key);

  final Function doReload;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          const Spacer(),
          Container(
            height: 32,
            child: Center(
              child: AppIcon(
                icon: AppIcons.error,
                width: 92,
                height: 92,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).loadListErrorMessageTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Button.reload(context: context, onPressed: doReload),
          const Spacer(),
        ],
      ),
    );
  }
}
