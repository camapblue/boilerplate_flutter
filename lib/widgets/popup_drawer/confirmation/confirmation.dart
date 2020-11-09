import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/theme/theme.dart';

import 'package:boilerplate_flutter/widgets/button/button.dart';
import 'package:boilerplate_flutter/widgets/app_icon/app_icon.dart';
import 'package:boilerplate_flutter/widgets/popup_drawer/popup_drawer_theme.dart';
import 'package:common/animated/animated.dart';

const double _DefaultWidthFactor = 256.0;
const double _HeaderHeight = 44.0;
const double _IconSize = 24.0;
const double _DefaultTitlePadding = 16.0;
const double _DefaultContentMargin = 12.0;
const double _DefaultMessagePaddingVertical = 24.0;
const double _DefaultMessagePaddingHorizontal = 40.0;
const double _TitlePaddingAlert = 0.0;
const double _ContentPaddingAlert = 0.0;
const double _BorderRadius = 12.0;

const ValueKey confirmationPopupKey = ValueKey('confirmation_popup_key');

class ConfirmationHeader extends StatelessWidget {
  final AppIcon icon;
  final String title;

  ConfirmationHeader({
    this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: _DefaultTitlePadding, right: _DefaultTitlePadding),
      height: _HeaderHeight,
      decoration: const ShapeDecoration(
        color: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_BorderRadius),
            topRight: Radius.circular(_BorderRadius),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: _IconSize,
                maxHeight: _IconSize,
              ),
              child: icon,
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(
                left: _DefaultTitlePadding, right: _DefaultTitlePadding),
            child: Text(
              title,
              style: Theme.of(context).popupDrawerTitleTextStyle,
              textAlign: TextAlign.center,
            ),
          )),
        ],
      ),
    );
  }
}

class ConfirmationContent extends StatelessWidget {
  final String message;
  ConfirmationContent({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: _DefaultMessagePaddingHorizontal,
            right: _DefaultMessagePaddingHorizontal,
            top: _DefaultMessagePaddingVertical,
            bottom: _DefaultMessagePaddingVertical),
        child: SpanLabel(
          text: message,
          textAlign: TextAlign.center,
          defaultStyle: Theme.of(context).popupDrawerContentDefaultTextStyle,
          boldStyle: Theme.of(context).popupDrawerContentBoldTextStyle,
          italicStyle: Theme.of(context).popupDrawerContentItalicTextStyle,
        ),
      ),
    );
  }
}

class Confirmation extends StatelessWidget {
  final AppIcon icon;
  final String title;
  final String message;
  final String okTitle;
  final String cancelTitle;

  Confirmation({
    Key key,
    this.icon,
    @required this.title,
    @required this.message,
    this.okTitle,
    this.cancelTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: confirmationPopupKey,
      color: Colors.black.withOpacity(0.54),
      child: Center(
        widthFactor: _DefaultWidthFactor,
        child: AnimatedBounce(
          child: AlertDialog(
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ConfirmationHeader(
                    icon: icon,
                    title: title,
                  ),
                  ConfirmationContent(
                    message: message,
                  ),
                ],
              ),
            ),
            titlePadding: const EdgeInsets.all(_TitlePaddingAlert),
            content: Container(
              margin: const EdgeInsets.all(_DefaultContentMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Button.cancel(
                      context: context,
                      size: ButtonSize.medium,
                      title: cancelTitle,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Button.ok(
                      context: context,
                      size: ButtonSize.medium,
                      title: okTitle,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(_ContentPaddingAlert),
            backgroundColor: blueColorLight,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_BorderRadius))),
          ),
        ),
      ),
    );
  }
}
