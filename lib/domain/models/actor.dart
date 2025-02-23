import 'package:thespian/domain/models/gender.dart';

class Actor {
  final bool adult;
  final String? biography;
  final DateTime? birthday;
  final DateTime? deathday;
  final Gender gender;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String profileImageUrl;
  final int tmdbId;

  Actor({
    this.adult = false,
    this.biography,
    this.birthday,
    this.deathday,
    required this.gender,
    required this.name,
    this.placeOfBirth,
    required this.popularity,
    required this.profileImageUrl,
    required this.tmdbId,
  });
}
