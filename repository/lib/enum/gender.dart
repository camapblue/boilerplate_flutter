enum Gender { male, female }

List<Gender> get allGenders => <Gender>[Gender.male, Gender.female];

Gender genderFromString({required String gender}) {
  if (gender.toLowerCase() == 'male') {
    return Gender.male;
  }

  return Gender.female;
}

extension GenderExtension on Gender {
  String toValue() {
    if (this == Gender.male) {
      return 'male';
    }
    return 'female';
  }

  String toText() {
    if (this == Gender.male) {
      return 'Male';
    }
    return 'Female';
  }
}
