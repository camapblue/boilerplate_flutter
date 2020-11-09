import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:boilerplate_flutter/widgets/span_label/mark_text_styles.dart';
import 'package:boilerplate_flutter/theme/theme.dart';

extension SpanLabelTheme on ThemeData {
  TextStyle get spanLabelDefaultStyle => primaryTextTheme.bodyText1;
  TextStyle get spanLabelBoldStyle => primaryTextTheme.headline1;
  TextStyle get spanLabelItalicStyle => primaryTextTheme.bodyText2;
  TextStyle get spanLabelBoldItalicStyle => primaryTextTheme.headline2;

  TextStyle get spanLabelCurrencyStyle1 => numberTextTheme.headline1;
  TextStyle get spanLabelCurrencyStyle2 => numberTextTheme.headline2;
  TextStyle get spanLabelCurrencyStyle3 => numberTextTheme.headline3;

  TextStyle get placedCoinTextStyle => numberTextTheme.headline1;
  TextStyle get backCoinTextStyle => numberTextTheme.headline2;
}

class Tag {
  static const String startBold = '[[';
  static const String endBold = ']]';

  static const String startItalic = '{{';
  static const String endItalic = '}}';

  static const String startBoldItalic = '[{';
  static const String endBoldItalic = '}]';

  static const String startCurrency = '[\$';
  static const String endCurrency = '\$]';

  static const String startNumber = '[~';
  static const String endNumber = '~]';

  static const String startFractionNumber = '[/';
  static const String endFractionNumber = '/]';
}

enum CurrencyStyle { style1, style2, style3 }

class SpanLabel extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final CurrencyStyle currencyStyle;

  final TextStyle defaultStyle;
  final TextStyle boldStyle;
  final TextStyle italicStyle;
  final TextStyle boldItalicStyle;

  SpanLabel({
    Key key,
    @required this.text,
    this.color = darkColor,
    this.fontSize = 15.0,
    this.textAlign = TextAlign.left,
    this.currencyStyle = CurrencyStyle.style3,
    this.defaultStyle,
    this.boldStyle,
    this.italicStyle,
    this.boldItalicStyle,
  })  : assert(text != null, '$runtimeType text can not be null'),
        super(key: key);

  TextStyle _getCurrencyStyle(BuildContext context) {
    switch (currencyStyle) {
      case CurrencyStyle.style1:
        return _applyColorAndFontSize(
            Theme.of(context).spanLabelCurrencyStyle1);
      case CurrencyStyle.style2:
        return _applyColorAndFontSize(
            Theme.of(context).spanLabelCurrencyStyle2);
      case CurrencyStyle.style3:
        return _applyColorAndFontSize(
            Theme.of(context).spanLabelCurrencyStyle3);
    }
    return _applyColorAndFontSize(Theme.of(context).spanLabelCurrencyStyle1);
  }

  List<AppTextSpan> _allTextSpans(BuildContext context) {
    return [
      AppTextSpan(
          Tag.startBold,
          Tag.endBold,
          boldStyle ??
              _applyColorAndFontSize(Theme.of(context).spanLabelBoldStyle)),
      AppTextSpan(
          Tag.startItalic,
          Tag.endItalic,
          italicStyle ??
              _applyColorAndFontSize(Theme.of(context).spanLabelItalicStyle)),
      AppTextSpan(
          Tag.startBoldItalic,
          Tag.endBoldItalic,
          boldItalicStyle ??
              _applyColorAndFontSize(
                  Theme.of(context).spanLabelBoldItalicStyle)),
      AppTextSpan(Tag.startCurrency, Tag.endCurrency,
          _getCurrencyStyle(context)),
      AppTextSpan(Tag.startNumber, Tag.endNumber,
          _applyColorAndFontSize(Theme.of(context).numberTextStyle)),
      AppTextSpan(
        Tag.startFractionNumber,
        Tag.endFractionNumber,
        _applyColorAndFontSize(Theme.of(context).thinTextTheme.bodyText1)
            .copyWith(
          fontFeatures: const [
            FontFeature.enable('frac'),
            FontFeature.enable('smcp')
          ],
        ),
      )
    ];
  }

  TextStyle _applyColorAndFontSize(TextStyle textStyle) {
    return textStyle.copyWith(color: color, fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: defaultStyle ??
            _applyColorAndFontSize(
              Theme.of(context).spanLabelDefaultStyle,
            ),
        children: AppTextSpan.buildTextSpans(text, _allTextSpans(context)),
      ),
    );
  }
}
