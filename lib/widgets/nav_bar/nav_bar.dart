import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final double statusBarHeight;
  final double toolbarHeight;
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final Color? backgroundColor;
  final List<BoxShadow> boxShadow;
  final Gradient? gradient;

  const NavBar({
    super.key,
    this.left,
    this.center,
    this.right,
    required this.statusBarHeight,
    this.toolbarHeight = 44,
    this.backgroundColor,
    this.gradient,
    this.boxShadow = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: statusBarHeight + toolbarHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          SizedBox(height: statusBarHeight),
          SizedBox(
            height: toolbarHeight,
            child: Stack(
              children: [
                if (left != null) Positioned(left: 12, child: left!),
                Center(child: center ?? const SizedBox()),
                if (right != null) Positioned(right: 12, child: right!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(statusBarHeight + toolbarHeight);
}
