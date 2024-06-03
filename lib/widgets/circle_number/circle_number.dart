import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/constants/constants.dart';

class CircleNumber extends StatelessWidget {
  const CircleNumber({
    super.key,
    this.color = Colors.black87,
    this.border,
    this.number = 0,
    this.max = 99,
    this.height = 24,
    this.autoResize = false,
    this.numberStyle,
  });
  
  final double height;
  final num number;
  final Color color;
  final TextStyle? numberStyle;
  final BoxBorder? border;
  final int max;
  final bool autoResize;

  String _buildNumberText() {
    if (max == 0 || number <= max) {
      return number.toString();
    }
    return '$max+';
  }

  TextStyle? _fontStyle(BuildContext context) {
    if (max == 0 || number <= max) {
      return numberStyle ??
          context.labelSmall?.copyWith(
            fontSize: 9,
            color: AppColors.neutral,
          );
    }
    if (numberStyle != null) {
      return numberStyle!.copyWith(fontSize: numberStyle!.fontSize ?? 9 * 0.8);
    }

    return context.labelSmall?.copyWith(
      fontSize: 8,
      color: AppColors.neutral,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: number > 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ConstrainedBox(
            constraints: autoResize
                ? BoxConstraints(minWidth: height)
                : BoxConstraints(minWidth: height, maxWidth: height),
            child: Container(
              alignment: Alignment.center,
              height: height,
              decoration: BoxDecoration(
                color: color,
                border: border,
                borderRadius: BorderRadius.circular(height / 2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: autoResize ? height / 5 : 0),
                child: Center(
                  child: Text(
                    _buildNumberText(),
                    style: _fontStyle(context),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
