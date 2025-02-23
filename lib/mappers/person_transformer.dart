import 'package:thespian/domain/models/actor_brief.dart';
import 'package:thespian/domain/models/gender.dart';
import 'package:thespian/mappers/common_transformers.dart';
import 'package:thespian/mappers/datetime_mapper.dart';
import 'package:thespian/tmdb/models/tmdb_person.dart';
import 'package:thespian/tmdb/models/tmdb_trending_person.dart';

import '../domain/models/actor.dart';

List<ActorBrief> mapPersonsToActorBriefs(List<TMDBPerson> people, {bool sort = true}) {
  final List<ActorBrief> actorList =
      people
          .where((p) => p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
          .map<ActorBrief>(
            (p) => ActorBrief(
              actor: mapPersonToActor(p),
              moviesKnownFor: mapKnownForToMovies(p.knownFor ?? []),
              tvShowsKnownFor: mapKnownForToTvShows(p.knownFor ?? []),
            ),
          )
          .toList();
  if (sort) actorList.sort((a, b) => a.actor.name.compareTo(b.actor.name));
  return actorList;
}

List<Actor> mapTrendingPersonsToActors(List<TMDBTrendingPerson> people, {bool sort = false}) {
  final List<Actor> actorList =
      people
          .where((p) => p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
          .map<Actor>(
            (p) => Actor(
              adult: p.adult,
              gender: p.gender.deriveGender(),
              name: p.name ?? '',
              popularity: p.popularity ?? 0.0,
              profileImageUrl: p.profilePath ?? '',
              tmdbId: p.id ?? 0,
            ),
          )
          .toList();
  if (sort) actorList.sort((a, b) => a.name.compareTo(b.name));
  return actorList;
}

List<Actor> mapPersonsToActors(List<TMDBPerson> people, {bool sort = false}) {
  final List<Actor> actorList =
      people
          .where((p) => p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
          .map<Actor>(
            (p) => Actor(
              biography: p.biography ?? '',
              birthday: parseDateTime(p.birthday),
              deathday: parseDateTime(p.deathday),
              gender: p.gender.deriveGender(),
              tmdbId: p.id ?? 0,
              name: p.name ?? '',
              popularity: p.popularity ?? 0.0,
              profileImageUrl: p.profilePath ?? '',
            ),
          )
          .toList();
  if (sort) actorList.sort((a, b) => a.name.compareTo(b.name));
  return actorList;
}
