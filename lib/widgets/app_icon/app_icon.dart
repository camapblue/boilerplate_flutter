import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  AppIcon({
    Key? key,
    required this.width,
    required this.height,
    this.color,
    required this.icon,
  }) : super(key: key);

  final AppIcons icon;
  final double width;
  final double height;
  final Color? color;

  factory AppIcon.closeCircle({
    double width = 20,
    double height = 20,
    Color color = const Color.fromRGBO(60, 60, 67, 0.6),
  }) {
    return AppIcon(
      icon: AppIcons.closeCircle,
      width: width,
      height: height,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.toAssetName(),
      width: width,
      height: height,
      color: color,
    );
  }
}
