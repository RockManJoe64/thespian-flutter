import 'package:thespian/domain/models/actor_brief.dart';
import 'package:thespian/mappers/common_transformers.dart';
import 'package:thespian/tmdb/tmdb_person.dart';

List<ActorBrief> mapPopularPersonToActorBriefs(List<TMDBPerson> people, {bool sort = true}) {
  final List<ActorBrief> actorList = people
      .where((p) =>
  p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
      .map<ActorBrief>((p) =>
      ActorBrief(
        adult: p.adult ?? false,
        gender: p.gender ?? 0,
        id: p.id ?? defaultIntValue,
        knownForDepartment: p.knownForDepartment ?? '',
        name: p.name ?? defaultName,
        popularity: p.popularity ?? 0,
        profilePath: p.profilePath ?? '',
        moviesKnownFor: mapKnownForToMovies(p.knownFor ?? []),
        tvShowsKnownFor: mapKnownForToTvShows(p.knownFor ?? []),
      ))
      .toList();
  if (sort) actorList.sort((a, b) => a.name.compareTo(b.name));
  return actorList;
}
