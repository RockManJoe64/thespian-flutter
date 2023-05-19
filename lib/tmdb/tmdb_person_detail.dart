import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_person_detail.freezed.dart';
part 'tmdb_person_detail.g.dart';

// TODO add known_for field to this model
@freezed
class TMDBPersonDetail with _$TMDBPersonDetail {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TMDBPersonDetail({
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
  }) = _TMDBPersonDetail;

  factory TMDBPersonDetail.fromJson(Map<String, dynamic> json) => _$TMDBPersonDetailFromJson(json);
}