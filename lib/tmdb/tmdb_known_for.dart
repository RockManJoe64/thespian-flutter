import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_known_for.freezed.dart';
part 'tmdb_known_for.g.dart';

/// Maps to the `known_for` property in various JSON objects returned by the TMDB API.
@freezed
class TmdbKnownFor with _$TmdbKnownFor {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TmdbKnownFor({
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
  }) = _TmdbKnownFor;

  factory TmdbKnownFor.fromJson(Map<String, dynamic> json) =>
      _$TmdbKnownForFromJson(json);
}