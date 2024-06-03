import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/theme/theme.dart';
import 'package:flutter/material.dart';

import 'mark_text_styles.dart';

class Tag {
  static const String startBold = '[[';
  static const String endBold = ']]';

  static const String startItalic = '{{';
  static const String endItalic = '}}';

  static const String startBoldItalic = '[{';
  static const String endBoldItalic = '}]';

  static const String startCoinCurrency = '[\$';
  static const String endCoinCurrency = '\$]';

  static const String startDiamondCurrency = '[@';
  static const String endDiamondCurrency = '@]';

  static const String startNumber = '[~';
  static const String endNumber = '~]';

  static const String startFractionNumber = '[/';
  static const String endFractionNumber = '/]';
}

enum CurrencyStyle { style1, style2, style3 }

class XSpanLabel extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final CurrencyStyle currencyStyle;

  final TextStyle? defaultStyle;
  final TextStyle? diamondStyle;
  final TextStyle? boldStyle;
  final TextStyle? italicStyle;
  final TextStyle? boldItalicStyle;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const XSpanLabel({
    super.key,
    required this.text,
    this.color = AppColors.dark,
    this.fontSize = 15.0,
    this.textAlign = TextAlign.left,
    this.currencyStyle = CurrencyStyle.style3,
    this.diamondStyle,
    this.defaultStyle,
    this.boldStyle,
    this.italicStyle,
    this.boldItalicStyle,
    this.maxLines,
    this.textOverflow,
  });

  TextStyle? _getCurrencyStyle() {
    final themeText = ThemeText.getNumberTextTheme();
    switch (currencyStyle) {
      case CurrencyStyle.style1:
        return _applyColorAndFontSize(themeText.titleSmall);
      case CurrencyStyle.style2:
        return _applyColorAndFontSize(themeText.bodySmall);
      case CurrencyStyle.style3:
        return _applyColorAndFontSize(themeText.labelSmall);
    }
  }

  List<AppTextSpan> _allTextSpans(BuildContext context) {
    return [
      AppTextSpan(
        Tag.startBold,
        Tag.endBold,
        boldStyle ??
            _applyColorAndFontSize(
              ThemeText.numberTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      AppTextSpan(
        Tag.startItalic,
        Tag.endItalic,
        italicStyle ??
            _applyColorAndFontSize(
              ThemeText.numberTextStyle.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
      ),
      AppTextSpan(
        Tag.startBoldItalic,
        Tag.endBoldItalic,
        boldItalicStyle ??
            _applyColorAndFontSize(
              ThemeText.numberTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
      ),
      AppTextSpan(
        Tag.startCoinCurrency,
        Tag.endCoinCurrency,
        _getCurrencyStyle(),
      ),
      AppTextSpan(
        Tag.startDiamondCurrency,
        Tag.endDiamondCurrency,
        diamondStyle ?? _getCurrencyStyle(),
      ),
      AppTextSpan(
        Tag.startNumber,
        Tag.endNumber,
        _applyColorAndFontSize(ThemeText.numberTextStyle),
      ),
      AppTextSpan(
        Tag.startFractionNumber,
        Tag.endFractionNumber,
        _applyColorAndFontSize(
          ThemeText.numberTextStyle.copyWith(
            fontFeatures: <FontFeature>[
              const FontFeature.alternativeFractions(),
              // const FontFeature.fractions(),
            ],
          ),
        ),
      ),
    ];
  }

  TextStyle? _applyColorAndFontSize(TextStyle? textStyle) {
    return textStyle?.copyWith(color: color, fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow ?? TextOverflow.clip,
      text: TextSpan(
        style: defaultStyle ?? _applyColorAndFontSize(
          ThemeText.numberTextStyle,
        ),
        children: AppTextSpan.buildTextSpans(text, _allTextSpans(context)),
      ),
    );
  }
}
