import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_person.freezed.dart';
part 'tmdb_person.g.dart';

// TODO add known_for field to this model
@freezed
class TMDBPerson with _$TMDBPerson {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TMDBPerson({
    bool? adult,
    List<String>? alsoKnownAs,
    String? biography,
    String? birthday,
    String? deathday,
    int? gender,
    String? homepage,
    int? id,
    String? imdbId,
    String? knownForDepartment,
    String? name,
    String? placeOfBirth,
    double? popularity,
    String? profilePath,
  }) = _TMDBPerson;

  factory TMDBPerson.fromJson(Map<String, dynamic> json) => _$TMDBPersonFromJson(json);
}