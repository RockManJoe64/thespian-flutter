import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_person_search_result.freezed.dart';
part 'tmdb_person_search_result.g.dart';

@freezed
class TMDBPersonSearchResult with _$TMDBPersonSearchResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TMDBPersonSearchResult({
    bool? adult,
    int? id,
    List<KnownFor>? knownFor,
    // TODO add knownForDepartment
    String? name,
    int? page,
    double? popularity,
    String? profilePath,
  }) = _TMDBPersonSearchResult;

  factory TMDBPersonSearchResult.fromJson(Map<String, dynamic> json) =>
      _$TMDBPersonSearchResultFromJson(json);
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
