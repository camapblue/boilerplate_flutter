import 'package:flutter/material.dart';
import 'package:boilerplate_flutter/global/global.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final cachedData = AppCaching().cacheImageData(image);

    return cachedData != null
        ? Image.memory(
            cachedData,
            width: width,
            height: height,
          )
        : Image(
            image: AssetImage(image),
            width: width,
            height: height,
          );
  }
}
