import 'package:repository/model/entity.dart';

class User extends Entity {
  final String userId;

  static User fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId']
    );
  }

  User({this.userId});

  @override
  List<Object> get props => [userId];
}