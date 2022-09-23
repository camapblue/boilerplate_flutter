import 'package:repository/model/model.dart';

class Authorization extends Entity {
  final String? profileToken;
  final String accessToken;

  Authorization({
    required this.accessToken,
    this.profileToken,
  });

  //ignore: prefer_constructors_over_static_methods
  static Authorization fromJson(Map<String, dynamic> json) {
    return Authorization(
      accessToken: json['access_token'],
      profileToken: json['profile_token'],
    );
  }

  @override
  List<Object> get props => [accessToken];

  @override
  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'profile_token': profileToken,
  };
}
