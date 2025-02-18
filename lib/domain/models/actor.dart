import 'package:thespian/domain/models/gender.dart';

class Actor {
  String? biography;
  DateTime? birthday;
  DateTime? deathday;
  Gender gender;
  int tmdbId;
  String name;
  String? placeOfBirth;
  double popularity;
  String profileImageUrl;

  Actor({
    this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    required this.tmdbId,
    required this.name,
    this.placeOfBirth,
    required this.popularity,
    required this.profileImageUrl,
  });
}
