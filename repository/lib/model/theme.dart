import 'dart:ui';

import 'package:repository/model/entity.dart';
import 'package:common/common.dart' show ColorExtension;

class Theme extends Entity {
  final String themeId;
  final Color primaryColor;
  final Color backgroundColor;

  static Theme fromJson(Map<String, dynamic> json) {
    return Theme(
      themeId: json['themeId'],
      primaryColor: ColorExtension.fromHex(json['primaryColor']),
      backgroundColor: ColorExtension.fromHex(json['backgroundColor'])
    );
  }

  Theme({this.themeId = 'default', this.primaryColor, this.backgroundColor});

  @override
  List<Object> get props => [themeId];
}