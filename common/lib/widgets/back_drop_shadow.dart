import 'dart:ui';

import 'package:flutter/material.dart';

class BackDropShadow extends StatelessWidget {
  BackDropShadow({
    Key? key,
    this.margin = const EdgeInsets.all(0),
    this.sigmaX = 0.0,
    this.sigmaY = 0.0,
    this.color = Colors.black87,
    required this.height,
    required this.width,
    required this.child,
    required this.imageSize,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final EdgeInsets margin;
  final double sigmaX;
  final double sigmaY;
  final double imageSize;
  final double width;
  final double height;
  final Alignment alignment;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: alignment,
            child: Container(
              height: imageSize,
              width: imageSize,
              margin: EdgeInsets.only(
                top: margin.top - sigmaY < 0 ? 0 : margin.top - sigmaY,
                bottom: margin.bottom + sigmaY,
                right: margin.right + sigmaX,
                left: margin.left - sigmaX < 0 ? 0 : margin.left - sigmaX,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                child: child,
              ),
            ),
          ),
          Align(
            alignment: alignment,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaX),
                child: Container(
                  height: imageSize,
                  width: imageSize,
                  margin: EdgeInsets.only(
                    top: margin.bottom,
                    bottom: margin.top,
                    right: margin.left,
                    left: margin.right,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
