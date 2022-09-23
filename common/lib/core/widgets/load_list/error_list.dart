import 'package:flutter/material.dart';

import 'load_list_theme.dart';

class ErrorList extends StatelessWidget {
  const ErrorList({
    Key? key,
    required this.errorMessage,
    this.errorIcon,
    required this.doReload,
  }) : super(key: key);

  final GestureTapCallback? doReload;
  final Widget? errorIcon;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          const Spacer(),
          errorIcon != null
              ? SizedBox(
                  height: 32,
                  child: Center(
                    child: errorIcon,
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: 1,
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
          InkWell(
            onTap: doReload,
            child: const Text('Reload'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
