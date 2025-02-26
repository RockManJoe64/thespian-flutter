import 'package:thespian/domain/models/movie_brief.dart';
import 'package:thespian/domain/models/tv_show_brief.dart';
import 'package:thespian/tmdb/models/tmdb_known_for.dart';

var defaultDateTime = DateTime(1900, 1, 1);
const defaultIntValue = -1;
const defaultName = 'No Name';

/// Convert a [String] to a [DateTime].
DateTime parseDateTime(String? value) =>
    value != null && value.isNotEmpty ? DateTime.parse(value) : defaultDateTime;

List<MovieBrief> mapKnownForToMovies(List<TmdbKnownFor> knownFor) => knownFor
    .where((k) => k.mediaType == 'movie' && k.adult == false)
    .map<MovieBrief>((k) => MovieBrief(
    adult: k.adult ?? false,
    genreIds: k.genreIds ?? [],
    id: k.id ?? defaultIntValue,
    mediaType: k.mediaType ?? '',
    originalLanguage: k.originalLanguage ?? '',
    title: k.title ?? defaultName,
    originalTitle: k.originalTitle ?? defaultName,
    overview: k.overview ?? '',
    posterPath: k.posterPath ?? '',
    backdropPath: k.backdropPath ?? '',
    releaseDate: parseDateTime(k.releaseDate),
    video: k.hasVideo ?? false,
    voteAverage: k.voteAverage ?? 0,
    voteCount: k.voteCount ?? 0))
    .toList();

List<TVShowBrief> mapKnownForToTvShows(List<TmdbKnownFor> knownFor) => knownFor
    .where((k) => k.mediaType == 'tv')
    .map<TVShowBrief>((k) => TVShowBrief(
    backdropPath: k.backdropPath ?? '',
    firstAirDate: parseDateTime(k.firstAirDate),
    genreIds: k.genreIds ?? [],
    id: k.id ?? defaultIntValue,
    mediaType: k.mediaType ?? '',
    name: k.name ?? defaultName,
    originalLanguage: k.originalLanguage ?? '',
    originalName: k.originalName ?? defaultName,
    overview: k.overview ?? '',
    originCountry: k.originCountry ?? [],
    posterPath: k.posterPath ?? '',
    voteAverage: k.voteAverage ?? 0,
    voteCount: k.voteCount ?? 0))
    .toList();
