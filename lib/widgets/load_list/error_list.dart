import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'load_list_theme.dart';

class ErrorList extends StatelessWidget {
  ErrorList({Key key, @required this.errorMessage, @required this.doReload})
      : super(key: key);

  final Function doReload;
  final String errorMessage;

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
                icon: AppIcons.error,
                width: 92,
                height: 92,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).loadListErrorMessageTextStyle,
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
