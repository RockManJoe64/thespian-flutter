import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_trending_person.freezed.dart';
part 'tmdb_trending_person.g.dart';

@freezed
class TMDBTrendingPerson with _$TMDBTrendingPerson {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TMDBTrendingPerson({
    required int id,
    required String name,
    required String originalName,
    required String mediaType,
    required bool adult,
    required double popularity,
    required int gender,
    required String knownForDepartment,
    String? profilePath,
  }) = _TMDBTrendingPerson;

  factory TMDBTrendingPerson.fromJson(Map<String, dynamic> json) => _$TMDBTrendingPersonFromJson(json);
}
