import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:boilerplate_flutter/models/models.dart';

class LoginButton extends BounceButton {
  LoginButton(
    BounceButtonTheme buttonTheme, {
    void Function()? onPressed,
    required BounceButtonDecoration decoration,
    required ButtonThemeStyle style,
    required Widget icon,
    double iconMargin = 16.0,
    String? title,
    String loadingText = '',
    double? width,
    double? height,
    double? fontSize,
    Color? color,
    Color? disabledColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    bool isLoading = false,
  }) : super(
          onPressed: onPressed,
          title: title,
          loadingText: loadingText,
          width: width,
          height: height ?? decoration.height,
          padding: padding,
          icon: icon,
          iconMargin: iconMargin,
          color: color ??
              (style == ButtonThemeStyle.normal
                  ? buttonTheme.color
                  : buttonTheme.lightColor),
          disabledColor: disabledColor ?? buttonTheme.disabledColor,
          normalTextStyle: buttonTheme.normalTextStyle
              .copyWith(fontSize: fontSize ?? decoration.fontSize),
          disabledTextStyle: buttonTheme.disabledTextStyle
                  .copyWith(fontSize: fontSize ?? decoration.fontSize),
          border: Border.all(width: 0, color: Colors.transparent),
          borderRadius: borderRadius ?? decoration.borderRadius,
          isLoading: isLoading,
          alignment: Alignment.centerLeft,
          loadingTextStyle: buttonTheme.normalTextStyle
              .copyWith(fontSize: fontSize ?? decoration.fontSize),
        );

  factory LoginButton.facebook({
    required BuildContext context,
    void Function()? onPressed,
    double? width,
    double? height,
    double fontSize = 28.0,
    double iconPadding = 24.0,
    bool isLoading = false,
    String? loadingText,
  }) {
    return LoginButton(
      Theme.of(context).blueButtonTheme.copyWith(
            color: blueColor.withOpacity(0.68),
          ),
      onPressed: onPressed,
      title: S.of(context).translate(Strings.Button.signInWithFacebook),
      loadingText: loadingText ??
          S.of(context).translate(
                Strings.Common.signingIn,
              ),
      width: width,
      height: height,
      fontSize:
          context.responsiveSizes([fontSize, fontSize * 0.9, fontSize * 0.85]),
      icon: Container(
        width: 60,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: iconPadding),
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: AppIcon(
            icon: AppIcons.facebook,
            width: 44,
            height: 30,
            color: onPressed != null ? whiteColor : lightGrayColor,
          ),
        ),
      ),
      iconMargin: 8,
      borderRadius: BorderRadius.circular(8),
      style: ButtonThemeStyle.normal,
      decoration: BounceButtonDecoration.size(ButtonSize.big,
          disabled: onPressed == null),
      isLoading: isLoading,
    );
  }

  factory LoginButton.google({
    required BuildContext context,
    void Function()? onPressed,
    double? width,
    double? height,
    double fontSize = 28.0,
    double iconPadding = 24.0,
    bool isLoading = false,
    String? loadingText,
  }) {
    return LoginButton(
      Theme.of(context).redButtonTheme.copyWith(
            color: redColor.withOpacity(0.68),
          ),
      onPressed: onPressed,
      title: S.of(context).translate(Strings.Button.signInWithGoogle),
      loadingText: loadingText ??
          S.of(context).translate(
                Strings.Common.signingIn,
              ),
      width: width,
      height: height,
      fontSize:
          context.responsiveSizes([fontSize, fontSize * 0.9, fontSize * 0.85]),
      icon: Container(
        width: 60,
        padding: EdgeInsets.only(left: iconPadding),
        child: Center(
          child: AppIcon(
            icon: AppIcons.googlePlus,
            width: 44,
            height: 30,
            color: onPressed != null ? whiteColor : lightGrayColor,
          ),
        ),
      ),
      iconMargin: 8,
      borderRadius: BorderRadius.circular(8),
      style: ButtonThemeStyle.normal,
      decoration: BounceButtonDecoration.size(ButtonSize.big,
          disabled: onPressed == null),
      isLoading: isLoading,
    );
  }

  factory LoginButton.apple({
    required BuildContext context,
    void Function()? onPressed,
    double? width,
    double? height,
    double fontSize = 28.0,
    double iconPadding = 24.0,
    bool isLoading = false,
    String? loadingText,
  }) {
    return LoginButton(
      Theme.of(context).redButtonTheme,
      color: Colors.black.withOpacity(0.68),
      disabledColor: Colors.grey.withOpacity(0.68),
      onPressed: onPressed,
      title: S.of(context).translate(Strings.Button.signInWithApple),
      loadingText: loadingText ??
          S.of(context).translate(
                Strings.Common.signingIn,
              ),
      width: width,
      height: height,
      fontSize:
          context.responsiveSizes([fontSize, fontSize * 0.9, fontSize * 0.85]),
      icon: Container(
        width: 60,
        padding: EdgeInsets.only(left: iconPadding),
        child: Center(
          child: AppIcon(
            icon: AppIcons.apple,
            width: 44,
            height: 30,
            color: onPressed != null ? whiteColor : lightGrayColor,
          ),
        ),
      ),
      iconMargin: 8,
      borderRadius: BorderRadius.circular(8),
      style: ButtonThemeStyle.normal,
      decoration: BounceButtonDecoration.size(ButtonSize.big,
          disabled: onPressed == null),
      isLoading: isLoading,
    );
  }
}
