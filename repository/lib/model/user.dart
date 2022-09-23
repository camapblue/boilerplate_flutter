import 'package:common/common.dart';
import 'package:repository/model/entity.dart';
import 'package:repository/enum/enum.dart';

class User extends Entity {
  final String userId;

  final String name;
  final String? occupation;
  final DateTime? birthday;
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
    required this.userId,
    required this.name,
    this.occupation,
    this.birthday,
    required this.gender,
  });

  factory User.test() {
    return User(userId: 'user_id', name: 'name', gender: Gender.female);
  }

  @override
  List<Object> get props => [userId];

  @override
  Map<String, dynamic> toJson() { 
    final json = <String, dynamic>{
        'userId': userId,
        'name': name,
        'gender': gender.toValue(),
      };
    if (birthday != null) {
      json['birthday'] = birthday!.secondsSinceEpoc;
    }
    if (occupation != null) {
      json['birthday'] = birthday!.secondsSinceEpoc;
    }
    return json;
  }
}