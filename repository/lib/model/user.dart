import 'package:common/common.dart';
import 'package:repository/model/entity.dart';
import 'package:repository/enum/enum.dart';

class User extends Entity {
  final String userId;

  final String name;
  final String occupation;
  final DateTime birthday;
  final Gender gender;

  //ignore: prefer_constructors_over_static_methods
  static User fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      occupation: json['occupation'],
      birthday: DateTimeExtension.fromSeconds(json['birthday']),
      name: json['name'],
      gender: genderFromString(gender: json['gender']),
    );
  }

  User({
    this.userId,
    this.name,
    this.occupation,
    this.birthday,
    this.gender,
  });

  @override
  List<Object> get props => [userId];

  @override
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'occupation': occupation,
        'birthday': birthday.secondsSinceEpoc,
        'name': name,
        'gender': gender.toValue(),
      };
}