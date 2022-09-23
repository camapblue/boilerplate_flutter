import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate_flutter/constants/app_colors.dart';
import 'package:boilerplate_flutter/theme/theme.dart';

final balanceFormatter = NumberFormat.currency(
  name: 'VND',
  symbol: '₫',
  decimalDigits: 0,
  locale: 'vi',
);

class Balance extends StatelessWidget {
  final double value;
  final TextStyle? textStyle;
  final bool crossLine;
  final bool showNegativeInZero;

  const Balance({
    required this.value,
    this.textStyle,
    this.crossLine = false,
    this.showNegativeInZero = false,
  });

  @override
  Widget build(BuildContext context) {
    final finalValue = value == 0 && showNegativeInZero ? -value : value;
    final formattedValue = balanceFormatter.format(finalValue);

    final style = textStyle ??
        Theme.of(context)
            .primaryBold
            .copyWith(color: AppColors.dark.withOpacity(0.6));

    return Text(
      formattedValue,
      style: crossLine
          ? style.copyWith(decoration: TextDecoration.lineThrough)
          : style,
    );
  }
}
