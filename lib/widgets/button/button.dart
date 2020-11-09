import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:common/widget.dart';
import 'package:boilerplate_flutter/constants/strings.dart';
import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:boilerplate_flutter/global/global.dart';

export 'ink_well_button.dart';
export 'login_button.dart';

class Button extends BounceButton {
  Button(
    BounceButtonTheme buttonTheme, {
    Function onPressed,
    double width,
    double height,
    @required BounceButtonDecoration decoration,
    @required ButtonThemeStyle style,
    @required String title,
    EdgeInsets padding,
    bool isLoading = false,
    String loadingText,
    TextStyle loadingTextStyle,
    Widget suffixIcon,
    Widget icon,
    double iconMargin,
    bool usingPointerDetector = false,
    Key key,
  }) : super(
          onPressed: onPressed,
          width: width,
          height: height ?? decoration.height,
          title: title,
          padding: padding,
          color: style == ButtonThemeStyle.normal
              ? buttonTheme.color
              : buttonTheme.lightColor,
          disabledColor: onPressed == null ? buttonTheme.disabledColor : null,
          normalTextStyle: buttonTheme.normalTextStyle
              .copyWith(fontSize: decoration.fontSize),
          disabledTextStyle: onPressed == null
              ? buttonTheme.disabledTextStyle
                  .copyWith(fontSize: decoration.fontSize)
              : null,
          border: decoration.border,
          borderRadius: decoration.borderRadius,
          isLoading: isLoading,
          loadingText: loadingText,
          loadingTextStyle: loadingTextStyle,
          suffixIcon: suffixIcon,
          icon: icon,
          iconMargin: iconMargin,
          key: key,
          usingPointerDetector: usingPointerDetector,
        );

  factory Button.green({
    @required BuildContext context,
    Function onPressed,
    double width,
    double height,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    @required String title,
    bool isLoading = false,
    Widget suffixIcon,
  }) {
    return Button(Theme.of(context).greenButtonTheme,
        onPressed: onPressed,
        width: width,
        height: height,
        style: style,
        title: title,
        decoration:
            BounceButtonDecoration.size(size, disabled: onPressed == null),
        isLoading: isLoading);
  }

  factory Button.red({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    double height,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    @required String title,
    Widget suffixIcon,
  }) {
    return Button(
      Theme.of(context).redButtonTheme,
      onPressed: onPressed,
      width: width,
      height: height ?? buttonHeightByButtonSize(size),
      style: style,
      title: title,
      decoration:
          BounceButtonDecoration.size(size, disabled: onPressed == null),
    );
  }

  factory Button.blue({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    double height,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    @required String title,
    bool isLoading = false,
    Widget suffixIcon,
  }) {
    return Button(
      Theme.of(context).blueButtonTheme,
      onPressed: onPressed,
      width: width,
      height: height ?? buttonHeightByButtonSize(size),
      style: style,
      title: title,
      decoration:
          BounceButtonDecoration.size(size, disabled: onPressed == null),
      isLoading: isLoading,
      suffixIcon: suffixIcon,
    );
  }

  factory Button.yellow({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    double height,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    @required String title,
    bool isLoading = false,
    Widget suffixIcon,
  }) {
    return Button(Theme.of(context).yellowButtonTheme,
        onPressed: onPressed,
        width: width,
        height: height ?? buttonHeightByButtonSize(size),
        style: style,
        title: title,
        decoration: BounceButtonDecoration.size(size,
            disabled: onPressed == null, borderColor: darkColor),
        isLoading: isLoading);
  }

  factory Button.noBorder({
    @required BounceButtonTheme buttonTheme,
    @required Function onPressed,
    double width,
    double height,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    @required String title,
    bool isLoading = false,
    Key key,
    bool usingPointerDetector = false,
  }) {
    return Button(
      buttonTheme,
      onPressed: onPressed,
      width: width,
      height: height ?? buttonHeightByButtonSize(size),
      style: style,
      title: title,
      decoration:
          BounceButtonDecoration.size(size, disabled: onPressed == null),
      isLoading: isLoading,
      key: key,
      usingPointerDetector: usingPointerDetector,
    );
  }

  factory Button.cancel({
    @required BuildContext context,
    @required Function onPressed,
    String title,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.light,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(Theme.of(context).redButtonTheme,
        onPressed: onPressed,
        width: width,
        height: buttonHeightByButtonSize(size),
        style: style,
        title: title ?? S.of(context).translate(Strings.Button.cancel),
        decoration:
            BounceButtonDecoration.size(size, disabled: onPressed == null),
        isLoading: isLoading);
  }

  factory Button.close({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.light,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(Theme.of(context).redButtonTheme,
        onPressed: onPressed,
        width: width,
        height: buttonHeightByButtonSize(size),
        style: style,
        title: S.of(context).translate(Strings.Button.close),
        decoration:
            BounceButtonDecoration.size(size, disabled: onPressed == null),
        isLoading: isLoading);
  }

  factory Button.save({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.light,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(
      Theme.of(context).greenButtonTheme,
      onPressed: onPressed,
      width: width,
      height: buttonHeightByButtonSize(size),
      style: style,
      title: S.of(context).translate(Strings.Button.save),
      decoration:
          BounceButtonDecoration.size(size, disabled: onPressed == null),
      isLoading: isLoading,
    );
  }

  factory Button.accept({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(Theme.of(context).yellowButtonTheme,
        onPressed: onPressed,
        width: width,
        height: buttonHeightByButtonSize(size),
        style: style,
        title: S.of(context).translate(Strings.Button.accept),
        decoration: BounceButtonDecoration.size(size,
            disabled: onPressed == null, borderColor: darkColor),
        isLoading: isLoading);
  }

  factory Button.reload({
    @required BuildContext context,
    @required Function onPressed,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(Theme.of(context).redButtonTheme,
        onPressed: onPressed,
        width: width,
        height: buttonHeightByButtonSize(size),
        style: style,
        title: S.of(context).translate(Strings.Button.reload),
        decoration:
            BounceButtonDecoration.size(size, disabled: onPressed == null),
        isLoading: isLoading);
  }

  factory Button.ok({
    @required BuildContext context,
    @required Function onPressed,
    String title,
    double width,
    ButtonThemeStyle style = ButtonThemeStyle.normal,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
  }) {
    return Button(Theme.of(context).blueButtonTheme,
        onPressed: onPressed,
        width: width,
        height: buttonHeightByButtonSize(size),
        style: style,
        title: title ?? 'OK',
        decoration:
            BounceButtonDecoration.size(size, disabled: onPressed == null),
        isLoading: isLoading);
  }
}
