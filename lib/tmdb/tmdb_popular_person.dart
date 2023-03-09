import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_popular_person.freezed.dart';
part 'tmdb_popular_person.g.dart';

@freezed
class TMDBPopularPerson with _$TMDBPopularPerson {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TMDBPopularPerson({
    bool? adult,
    int? id,
    List<KnownFor>? knownFor,
    String? name,
    int? page,
    double? popularity,
    String? profilePath,
  }) = _TMDBPopularPerson;

  factory TMDBPopularPerson.fromJson(Map<String, dynamic> json) =>
      _$TMDBPopularPersonFromJson(json);
}

@freezed
class KnownFor with _$KnownFor {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory KnownFor({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? mediaType,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? hasVideo,
    double? voteAverage,
    int? voteCount,
    String? firstAirDate,
    String? name,
    String? originalName,
    List<String>? originCountry,
  }) = _KnownFor;

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);
}
