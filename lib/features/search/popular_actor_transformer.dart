import 'package:thespian/common/image_path_utils.dart';
import 'package:thespian/domain/models/search_result.dart';
import 'package:thespian/features/popular_actors/popular_actor_view_model.dart';
import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';

PopularActor mapToPopularActor(TMDBImageConfiguration config, SearchResult searchResult) {
  final actorBrief = searchResult.actorBrief!;
  final movies = AppearsIn.fromMoviesKnownFor(config, actorBrief.moviesKnownFor!);
  final tvShows = AppearsIn.fromTvShowsKnownFor(config, actorBrief.tvShowsKnownFor!);
  return PopularActor(
    id: actorBrief.actor.tmdbId,
    name: actorBrief.actor.name,
    popularity: actorBrief.actor.popularity,
    smallProfileImageUrl: parseImagePath(
      config.secureBaseUrl,
      config.profileSizes[smallProfileImageSizeIndex],
      actorBrief.actor.profileImageUrl,
    ),
    largeProfileImageUrl: parseImagePath(
      config.secureBaseUrl,
      config.profileSizes[largeProfileImageSizeIndex],
      actorBrief.actor.profileImageUrl,
    ),
    appearsIn: [...movies, ...tvShows],
  );
}
