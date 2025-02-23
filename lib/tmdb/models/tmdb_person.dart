import 'package:freezed_annotation/freezed_annotation.dart';

import 'tmdb_known_for.dart';

part 'tmdb_person.freezed.dart';
part 'tmdb_person.g.dart';

/// Maps to the object returned by the TMDB API endpoints:
/// - `/person/popular`.
/// - `/person/{person_id}`.
/// - `/search/person` endpoint.
///
/// See: https://developers.themoviedb.org/3/people/get-popular-people
@freezed
class TMDBPerson with _$TMDBPerson {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TMDBPerson({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    String? birthday,
    String? deathday,
    int? gender,
    int? id,
    List<TmdbKnownFor>? knownFor, // Specific to popular people endpoint.
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    String? originalName,
    double? popularity, // Specific to popular, trending people endpoint.
    String? profilePath,
  }) = _TMDBPerson;

  factory TMDBPerson.fromJson(Map<String, dynamic> json) => _$TMDBPersonFromJson(json);
}
