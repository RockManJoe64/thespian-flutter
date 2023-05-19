import 'package:freezed_annotation/freezed_annotation.dart';

import 'tmdb_known_for.dart';

part 'tmdb_person.freezed.dart';
part 'tmdb_person.g.dart';

/// Maps to the object returned by the TMDB API endpoint `/person/popular`.
///
/// This also maps to the objects returned by the `/search/person` endpoint.
///
/// See: https://developers.themoviedb.org/3/people/get-popular-people
@freezed
class TMDBPerson with _$TMDBPerson {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TMDBPerson({
    bool? adult,
    int? gender,
    int? id,
    List<KnownFor>? knownFor,
    String? knownForDepartment,
    String? name,
    int? page,
    double? popularity,
    String? profilePath,
  }) = _TMDBPerson;

  factory TMDBPerson.fromJson(Map<String, dynamic> json) =>
      _$TMDBPersonFromJson(json);
}
