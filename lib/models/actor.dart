import 'package:thespian/models/gender.dart';

class Actor {
  String? biography;
  DateTime? birthday;
  DateTime? deathday;
  Gender gender;
  String? homepage;
  int id;
  String? imdbId;
  String name;
  String? placeOfBirth;
  double popularity;
  String profileImageUrl;

  Actor({
    this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.name,
    this.placeOfBirth,
    required this.popularity,
    required this.profileImageUrl,
  });
}
