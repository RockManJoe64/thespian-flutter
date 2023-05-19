import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_known_for.freezed.dart';
part 'tmdb_known_for.g.dart';

/// Maps to the `known_for` property in various JSON objects returned by the TMDB API.
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