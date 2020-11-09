import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/app_icon/app_icon.dart';

import 'base_popup_drawer.dart';
import 'confirmation/confirmation.dart';
import 'alert/alert.dart';

export 'alert/alert.dart';
export 'confirmation/confirmation.dart';

class PopupDrawer {
  final BuildContext context;

  PopupDrawer.of(this.context);

  BasePopupDrawer confirmation({
    Key key,
    @required String title,
    @required String message,
    String okTitle,
    String cancelTitle,
    AppIcon icon,
  }) {
    return BasePopupDrawer(
      context: context,
      key: key,
      child: Confirmation(
        title: title,
        message: message,
        okTitle: okTitle,
        cancelTitle: cancelTitle,
        icon: icon,
      ),
    );
  }

  BasePopupDrawer error({
    Key key,
    Function onYes,
    @required String title,
    @required String message,
    AppIcon icon,
  }) {
    return BasePopupDrawer(
      context: context,
      key: key,
      child: Alert.error(
        onYes: onYes,
        title: title,
        message: message,
        icon: icon ??
            AppIcon(
                icon: AppIcons.error,
                color: Colors.white,
                width: 64,
                height: 64),
      ),
    );
  }

  BasePopupDrawer warning({
    Key key,
    @required Function onYes,
    @required String title,
    @required String message,
    AppIcon icon,
  }) {
    return BasePopupDrawer(
      context: context,
      key: key,
      child: Alert.warning(
        onYes: onYes,
        title: title,
        message: message,
        icon: icon,
      ),
    );
  }

  BasePopupDrawer announcement({
    Key key,
    @required Function onYes,
    @required String title,
    @required String message,
    String okButtonTitle,
    AppIcon icon,
  }) {
    return BasePopupDrawer(
      context: context,
      key: key,
      child: Alert.announcement(
        onYes: onYes,
        title: title,
        message: message,
        icon: icon,
        okButtonTitle: okButtonTitle,
      ),
    );
  }

  BasePopupDrawer open({
    Key key,
    @required Widget widget,
  }) {
    return BasePopupDrawer(
      context: context,
      key: key,
      child: widget,
    );
  }
}
