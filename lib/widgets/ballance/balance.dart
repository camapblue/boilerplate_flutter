import 'package:boilerplate_flutter/constants/app_constants.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  final double value;
  final TextStyle? textStyle;
  final bool crossLine;
  final bool showNegativeInZero;

  const Balance({
    super.key,
    required this.value,
    this.textStyle,
    this.crossLine = false,
    this.showNegativeInZero = false,
  });

  @override
  Widget build(BuildContext context) {
    final finalValue = value == 0 && showNegativeInZero ? -value : value;
    final formattedValue = AppConstants.balanceFormatter.format(finalValue);

    final style = textStyle ??
        context.bodyMedium?.copyWith(color: AppColors.dark.withOpacity(0.6));

    return Text(
      formattedValue,
      style: crossLine
          ? style?.copyWith(decoration: TextDecoration.lineThrough)
          : style,
    );
  }
}
