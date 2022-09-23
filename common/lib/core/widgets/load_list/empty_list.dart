import 'package:flutter/material.dart';
import 'load_list_theme.dart';

class EmptyList extends StatelessWidget {
  final String emptyMessage;
  final Widget? emptyIcon;
  final Color color;
  final GestureTapCallback? onReload;

  const EmptyList({
    Key? key,
    required this.emptyMessage,
    this.emptyIcon,
    this.color = Colors.white,
    this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emptyIcon != null
              ? SizedBox(
                  height: 64,
                  child: Center(
                    child: emptyIcon,
                  ),
                )
              : const SizedBox(),
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
          if (onReload != null)
            SizedBox(
              width: 100,
              child: InkWell(
                onTap: onReload,
                child: const Text('Reload'),
              ),
            )
        ],
      ),
    );
  }
}
