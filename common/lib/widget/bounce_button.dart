import 'package:common/widget.dart';
import 'package:common/widget/bounce.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  EdgeInsets get paddingIfNeeded => fontFamily == 'FjallaOne'
      ? const EdgeInsets.only(bottom: 4)
      : const EdgeInsets.only();
}

const TextStyle _DefaultNormalTextStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 19.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    height: 1.5);

const TextStyle _DefaultDisabledTextStyle = TextStyle(
    color: Color(0xFF999999),
    fontSize: 19.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    height: 1.5);

const Color _DefaultColor = Color(0xFF378019);
const Color _DefaultDisabledColor = Color(0xFFAAAAAA);
final BoxBorder _defaultBorder = Border.all(width: 4, color: Colors.white);
const EdgeInsets _DefaultPadding =
    EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0);

class BounceButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final String title;
  final String loadingText;
  final TextStyle loadingTextStyle;
  final Widget icon;
  final Widget suffixIcon;
  final double iconMargin;
  final Color color;
  final Color disabledColor;
  final EdgeInsets padding;
  final BoxBorder border;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadow;
  final TextStyle normalTextStyle;
  final TextStyle disabledTextStyle;
  final bool supportLongPress;
  final bool usingPointerDetector;
  final bool isLoading;
  final Alignment alignment;
  final BounceScale bounceScale;

  BounceButton({
    Key key,
    this.onPressed,
    this.width,
    this.height = double.infinity,
    this.title,
    this.loadingText,
    this.loadingTextStyle,
    this.icon,
    this.suffixIcon,
    this.iconMargin = 16.0,
    this.color = _DefaultColor,
    this.padding,
    this.disabledColor = _DefaultDisabledColor,
    this.border,
    this.borderRadius,
    this.shadow,
    this.normalTextStyle = _DefaultNormalTextStyle,
    this.disabledTextStyle = _DefaultDisabledTextStyle,
    this.supportLongPress = false,
    this.usingPointerDetector = false,
    this.isLoading = false,
    this.bounceScale = BounceScale.smaller,
    this.alignment = Alignment.center,
  }) : super(key: key);

  MainAxisAlignment get _axisAlignment => (alignment == Alignment.center ||
          alignment == Alignment.topCenter ||
          alignment == Alignment.bottomCenter)
      ? (suffixIcon == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween)
      : (alignment == Alignment.topLeft ||
              alignment == Alignment.centerLeft ||
              alignment == Alignment.bottomLeft)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end;

  List<Widget> _loading() {
    if (icon != null) {
      return <Widget>[
        icon,
        SizedBox(
          width: iconMargin,
        ),
        LoadingText(
          text: loadingText,
          textStyle: loadingTextStyle ?? normalTextStyle,
        )
      ];
    }

    return <Widget>[
      LoadingText(
        text: loadingText,
        textStyle: loadingTextStyle ?? normalTextStyle,
      )
    ];
  }

  List<Widget> _content() {
    if (isLoading) {
      return _loading();
    }

    if (icon != null) {
      return title == null
          ? <Widget>[icon]
          : <Widget>[
              icon,
              SizedBox(
                width: iconMargin,
              ),
              getTitle,
              suffixIcon ?? const SizedBox()
            ];
    }

    return <Widget>[
      getTitle,
      suffixIcon ?? const SizedBox(),
    ];
  }

  Widget get getTitle {
    final textStyle = onPressed != null ? normalTextStyle : disabledTextStyle;
    return Padding(
      padding: textStyle.paddingIfNeeded,
      child: Text(
        title,
        style: textStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: isLoading ? null : onPressed,
      bounceScale: bounceScale,
      supportLongPress: supportLongPress,
      usingPointerDetector: usingPointerDetector,
      child: Container(
        width: width,
        height: height,
        padding: width == null ? (padding ?? _DefaultPadding) : null,
        decoration: BoxDecoration(
          border: border ?? _defaultBorder,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: onPressed != null ? color : disabledColor,
          boxShadow: shadow ??
              [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 1.0,
                  offset: Offset(0.2, 0.2),
                )
              ],
        ),
        child: Row(
          mainAxisAlignment: _axisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: _content(),
        ),
      ),
    );
  }
}
