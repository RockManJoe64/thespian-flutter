enum Gender {
  unspecified,
  female,
  male,
  other,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.unspecified:
        return 'Unspecified';
      case Gender.female:
        return 'Female';
      case Gender.male:
        return 'Male';
      case Gender.other:
        return 'Other';
      default:
        throw ArgumentError('Invalid gender: $this');
    }
  }
}

Gender genderFromInt(int value) {
  switch (value) {
    case 0:
      return Gender.other;
    case 1:
      return Gender.female;
    case 2:
      return Gender.male;
    default:
      return Gender.unspecified;
  }
}
