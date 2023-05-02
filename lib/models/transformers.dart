import 'package:thespian/models/actor_brief.dart';
import 'package:thespian/models/movie_brief.dart';
import 'package:thespian/models/tv_show_brief.dart';
import 'package:thespian/tmdb/tmdb_known_for.dart';
import 'package:thespian/tmdb/tmdb_person.dart';

var _defaultDateTime = DateTime(1900, 1, 1);
const defaultIntValue = -1;
const defaultName = 'No Name';

/// Convert a [String] to a [DateTime].
DateTime _parseDateTime(String? value) =>
    value != null ? DateTime.parse(value) : _defaultDateTime;

List<MovieBrief> _mapKnownForToMovies(List<KnownFor> knownFor) => knownFor
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
        releaseDate: _parseDateTime(k.releaseDate),
        video: k.hasVideo ?? false,
        voteAverage: k.voteAverage ?? 0,
        voteCount: k.voteCount ?? 0))
    .toList();

List<TVShowBrief> _mapKnownForToTvShows(List<KnownFor> knownFor) => knownFor
    .where((k) => k.mediaType == 'tv')
    .map<TVShowBrief>((k) => TVShowBrief(
        backdropPath: k.backdropPath ?? '',
        firstAirDate: _parseDateTime(k.firstAirDate),
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

List<ActorBrief> mapPopularPersonToActorBriefs(List<TMDBPerson> people) =>
    people
        .where((p) =>
            p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
        .map<ActorBrief>((p) => ActorBrief(
            adult: p.adult ?? false,
            gender: p.gender ?? 0,
            id: p.id ?? defaultIntValue,
            knownForDepartment: p.knownForDepartment ?? '',
            name: p.name ?? defaultName,
            popularity: p.popularity ?? 0,
            profilePath: p.profilePath ?? '',
            moviesKnownFor: _mapKnownForToMovies(p.knownFor ?? []),
            tvShowsKnownFor: _mapKnownForToTvShows(p.knownFor ?? []),
            ))
        .toList()
      ..sort((a, b) => b.popularity.compareTo(a.popularity));
