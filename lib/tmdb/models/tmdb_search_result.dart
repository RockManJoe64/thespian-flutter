import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thespian/tmdb/models/tmdb_known_for.dart';

part 'tmdb_search_result.freezed.dart';
part 'tmdb_search_result.g.dart';

@freezed
class TMDBSearchResult with _$TMDBSearchResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TMDBSearchResult({
    bool? adult,
    String? backdropPath,
    String? firstAirDate,
    int? gender,
    List<int>? genreIds,
    bool? hasVideo,
    int? id,
    List<TmdbKnownFor>? knownFor,
    String? knownForDepartment,
    String? mediaType,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? originalTitle,
    List<String>? originCountry,
    String? overview,
    String? posterPath,
    double? popularity,
    String? profilePath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _TMDBSearchResult;

  factory TMDBSearchResult.fromJson(Map<String, dynamic> json) =>
      _$TMDBSearchResultFromJson(json);
}
