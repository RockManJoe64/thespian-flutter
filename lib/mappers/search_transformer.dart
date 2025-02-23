import 'package:thespian/common/media_types.dart';
import 'package:thespian/domain/models/actor.dart';
import 'package:thespian/domain/models/actor_brief.dart';
import 'package:thespian/domain/models/gender.dart';
import 'package:thespian/domain/models/movie_brief.dart';
import 'package:thespian/domain/models/search_result.dart';
import 'package:thespian/domain/models/tv_show_brief.dart';
import 'package:thespian/mappers/common_transformers.dart';
import 'package:thespian/mappers/datetime_mapper.dart';
import 'package:thespian/tmdb/models/tmdb_search_result.dart';

TVShowBrief _mapToTVShowBrief(TMDBSearchResult result) {
  return TVShowBrief(
    backdropPath: result.backdropPath ?? '',
    firstAirDate: parseDateTime(result.firstAirDate),
    genreIds: result.genreIds ?? [],
    id: result.id ?? defaultIntValue,
    mediaType: result.mediaType ?? '',
    name: result.name ?? defaultName,
    originalLanguage: result.originalLanguage ?? '',
    originalName: result.originalName ?? defaultName,
    overview: result.overview ?? '',
    originCountry: result.originCountry ?? [],
    posterPath: result.posterPath ?? '',
    voteAverage: result.voteAverage ?? 0,
    voteCount: result.voteCount ?? 0,
  );
}

MovieBrief _mapToMovieBrief(TMDBSearchResult result) {
  return MovieBrief(
    adult: result.adult ?? false,
    genreIds: result.genreIds ?? [],
    id: result.id ?? defaultIntValue,
    mediaType: result.mediaType ?? '',
    originalLanguage: result.originalLanguage ?? '',
    title: result.title ?? defaultName,
    originalTitle: result.originalTitle ?? defaultName,
    overview: result.overview ?? '',
    posterPath: result.posterPath ?? '',
    backdropPath: result.backdropPath ?? '',
    releaseDate: parseDateTime(result.releaseDate),
    video: result.hasVideo ?? false,
    voteAverage: result.voteAverage ?? 0,
    voteCount: result.voteCount ?? 0,
  );
}

ActorBrief _mapToActorBrief(TMDBSearchResult result) {
  final actor = Actor(
    adult: result.adult ?? false,
    gender: result.gender.deriveGender(),
    tmdbId: result.id ?? defaultIntValue,
    name: result.name ?? defaultName,
    popularity: result.popularity ?? 0,
    profileImageUrl: result.profilePath ?? '',
  );
  return ActorBrief(
    actor: actor,
    moviesKnownFor: mapKnownForToMovies(result.knownFor ?? []),
    tvShowsKnownFor: mapKnownForToTvShows(result.knownFor ?? []),
  );
}

String _mapToName(TMDBSearchResult result) {
  if (result.mediaType == mediaTypeMovie) {
    return result.title ?? 'Movie';
  } else if (result.mediaType == mediaTypeTV) {
    return result.name ?? 'TV Show';
  } else if (result.mediaType == mediaTypePerson) {
    return result.name ?? 'Actor';
  } else {
    return defaultName;
  }
}

String _mapToImagePath(TMDBSearchResult result) {
  if (result.mediaType == mediaTypeMovie) {
    return result.posterPath ?? '';
  } else if (result.mediaType == mediaTypeTV) {
    return result.posterPath ?? '';
  } else if (result.mediaType == mediaTypePerson) {
    return result.profilePath ?? '';
  } else {
    return '';
  }
}

List<SearchResult> mapToSearchResults(List<TMDBSearchResult> results, {bool sort = true}) {
  final List<SearchResult> searchResults =
      results
          .where((r) => r.mediaType == mediaTypeMovie || r.mediaType == mediaTypeTV || r.mediaType == mediaTypePerson)
          .map<SearchResult>(
            (r) => SearchResult(
              id: r.id ?? defaultIntValue,
              name: _mapToName(r),
              imagePath: _mapToImagePath(r),
              mediaType: r.mediaType ?? '',
              actorBrief: r.mediaType == mediaTypePerson ? _mapToActorBrief(r) : null,
              movieBrief: r.mediaType == mediaTypeMovie ? _mapToMovieBrief(r) : null,
              tvShowBrief: r.mediaType == mediaTypeTV ? _mapToTVShowBrief(r) : null,
            ),
          )
          .toList();
  if (sort) searchResults.sort((a, b) => a.name.compareTo(b.name));
  return searchResults;
}

List<SearchResult> mapFromActorBriefs(List<ActorBrief> actorBriefs, {bool sort = true}) {
  final List<SearchResult> searchResults =
      actorBriefs
          .map(
            (a) => SearchResult(
              id: a.actor.tmdbId,
              name: a.actor.name,
              imagePath: a.actor.profileImageUrl,
              mediaType: mediaTypePerson,
              actorBrief: a,
            ),
          )
          .toList();
  if (sort) searchResults.sort((a, b) => a.name.compareTo(b.name));
  return searchResults;
}

List<SearchResult> mapFromActors(List<Actor> actorBriefs, {bool sort = true}) {
  final List<SearchResult> searchResults =
      actorBriefs
          .map(
            (a) => SearchResult(
              id: a.tmdbId,
              name: a.name,
              imagePath: a.profileImageUrl,
              mediaType: mediaTypePerson,
              actorBrief: ActorBrief(actor: a),
            ),
          )
          .toList();
  if (sort) searchResults.sort((a, b) => a.name.compareTo(b.name));
  return searchResults;
}
