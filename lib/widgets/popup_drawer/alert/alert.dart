// ignore_for_file: constant_identifier_names

import 'package:boilerplate_flutter/constants/app_colors.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/widgets/popup_drawer/popup_drawer_theme.dart';
import 'package:common/animated/animated.dart';

extension AlertTheme on ThemeData {
  Color get alertHeaderColorForError => AppColors.negative;
  Color get alertHeaderColorForWarning => AppColors.warning;
  Color get alertHeaderColorForAnnouncement => AppColors.neutral;

  Color get alertBackgroundColorForError => AppColors.negative;
  Color get alertBackgroundColorForWarning => AppColors.warningLight;
  Color get alertBackgroundColorForAnnouncement => AppColors.neutralLight;
}

const double _DefaultWidthFactor = 256.0;
const double _HeaderHeight = 44.0;
const double _IconSize = 24.0;
const double _DefaultTitlePadding = 16.0;
const double _DefaultContentMargin = 12.0;
const double _DefaultMessagePaddingVertical = 24.0;
const double _DefaultMessagePaddingHorizontal = 16.0;
const double _TitlePaddingAlert = 0.0;
const double _ContentPaddingAlert = 0.0;
const double _BorderRadius = 12.0;

const ValueKey alertPopupDrawerKey = ValueKey('alert_popup_drawer_key');

enum AlertType { error, warning, announcement }

class AlertHeader extends StatelessWidget {
  final AlertType alertType;
  final AppIcon? icon;
  final String? title;
  final Color? textColor;

  const AlertHeader({
    super.key,
    required this.alertType,
    this.icon,
    this.title,
    this.textColor,
  });

  Color _getHeaderColor(BuildContext context) {
    switch (alertType) {
      case AlertType.error:
        return AlertTheme(Theme.of(context)).alertHeaderColorForError;
      case AlertType.warning:
        return AlertTheme(Theme.of(context)).alertHeaderColorForWarning;
      case AlertType.announcement:
        return AlertTheme(Theme.of(context)).alertHeaderColorForAnnouncement;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: _DefaultTitlePadding, right: _DefaultTitlePadding),
      height: _HeaderHeight,
      decoration: ShapeDecoration(
        color: _getHeaderColor(context),
        shape: const RoundedRectangleBorder(
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: _DefaultTitlePadding),
              child: Text(
                title ?? '',
                style: Theme.of(context)
                    .popupDrawerTitleTextStyle
                    .copyWith(color: textColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlertContent extends StatelessWidget {
  final String? message;
  final Color? textColor;

  const AlertContent({super.key, 
    this.message,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: _DefaultMessagePaddingHorizontal,
          right: _DefaultMessagePaddingHorizontal,
          top: _DefaultMessagePaddingVertical,
          bottom: _DefaultMessagePaddingVertical),
      child: SpanLabel(
        text: message ?? '',
        textAlign: TextAlign.center,
        defaultStyle: Theme.of(context)
            .popupDrawerContentDefaultTextStyle
            .copyWith(color: textColor),
        boldStyle: Theme.of(context)
            .popupDrawerContentBoldTextStyle
            .copyWith(color: textColor),
        italicStyle: Theme.of(context)
            .popupDrawerContentItalicTextStyle
            .copyWith(color: textColor),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  final AppIcon? icon;
  final String title;
  final String message;
  final String? okButtonTitle;
  final void Function()? onYes;
  final AlertType alertType;
  final Color textColor;

  const Alert.error({
    Key? key,
    this.icon,
    required this.title,
    required this.message,
    this.okButtonTitle,
    this.textColor = Colors.white,
    this.onYes,
  })  : alertType = AlertType.error,
        super(key: key);

  const Alert.warning({
    Key? key,
    this.icon,
    required this.title,
    required this.message,
    this.okButtonTitle,
    this.textColor = Colors.black,
    this.onYes,
  })  : alertType = AlertType.warning,
        super(key: key);

  const Alert.announcement({
    Key? key,
    this.icon,
    required this.title,
    required this.message,
    this.okButtonTitle,
    this.textColor = Colors.white,
    this.onYes,
  })  : alertType = AlertType.announcement,
        super(key: key);

  Color _getBackgroundColor(BuildContext context) {
    switch (alertType) {
      case AlertType.error:
        return AlertTheme(Theme.of(context)).alertBackgroundColorForError;
      case AlertType.warning:
        return AlertTheme(Theme.of(context)).alertBackgroundColorForWarning;
      case AlertType.announcement:
        return AlertTheme(Theme.of(context))
            .alertBackgroundColorForAnnouncement;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: alertPopupDrawerKey,
      color: Colors.black.withOpacity(0.54),
      child: Center(
        widthFactor: _DefaultWidthFactor,
        child: AnimatedBounce(
          child: AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AlertHeader(
                  alertType: alertType,
                  icon: icon,
                  title: title,
                  textColor: textColor,
                ),
                AlertContent(
                  message: message,
                  textColor: textColor,
                ),
              ],
            ),
            titlePadding: const EdgeInsets.all(_TitlePaddingAlert),
            content: Container(
              margin: const EdgeInsets.all(_DefaultContentMargin),
              child: XButton.positive(
                onPressed: () {
                  if (onYes != null) {
                    onYes!();
                  }
                  Navigator.of(context).pop();
                },
                title: okButtonTitle,
              ),
            ),
            contentPadding: const EdgeInsets.all(_ContentPaddingAlert),
            backgroundColor: _getBackgroundColor(context),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(_BorderRadius))),
          ),
        ),
      ),
    );
  }
}
