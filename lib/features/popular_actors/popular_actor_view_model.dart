import 'package:thespian/common/image_path_utils.dart';
import 'package:thespian/models/actor_brief.dart';
import 'package:thespian/models/movie_brief.dart';
import 'package:thespian/models/tv_show_brief.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';

class PopularActor {
  int id;
  String name;
  double popularity;
  String smallProfileImageUrl;
  String largeProfileImageUrl;
  List<AppearsIn> appearsIn;

  PopularActor({
    required this.id,
    required this.name,
    required this.popularity,
    required this.smallProfileImageUrl,
    required this.largeProfileImageUrl,
    required this.appearsIn,
  });

  bool get containsSmallProfileImage => smallProfileImageUrl.isNotEmpty;
  bool get containsLargeProfileImage => largeProfileImageUrl.isNotEmpty;

  static fromActorBrief(TMDBImageConfiguration config, ActorBrief actorBrief) {
    final movies = AppearsIn.fromMoviesKnownFor(config, actorBrief.moviesKnownFor!);
    final tvShows = AppearsIn.fromTvShowsKnownFor(config, actorBrief.tvShowsKnownFor!);
    return PopularActor(
      id: actorBrief.id,
      name: actorBrief.name,
      popularity: actorBrief.popularity,
      smallProfileImageUrl: parseImagePath(config.secureBaseUrl, config.profileSizes[smallProfileImageSizeIndex], actorBrief.profilePath),
      largeProfileImageUrl: parseImagePath(config.secureBaseUrl, config.profileSizes[largeProfileImageSizeIndex], actorBrief.profilePath),
      appearsIn: [...movies, ...tvShows],
    );
  }
}

class AppearsIn {
  int id;
  String mediaType;
  List<String>? originCountry;
  String overview;
  String posterImageUrl;
  String backdropImageUrl;
  DateTime? releaseOrFirstAirDate;
  String titleOrName;
  double voteAverage;

  AppearsIn({
    required this.id,
    required this.mediaType,
    this.originCountry,
    required this.overview,
    required this.posterImageUrl,
    required this.backdropImageUrl,
    this.releaseOrFirstAirDate,
    required this.titleOrName,
    required this.voteAverage,
  });

  static fromMoviesKnownFor(TMDBImageConfiguration config, List<MovieBrief> movies) {
    return movies.map((movie) => AppearsIn(
      id: movie.id,
      mediaType: movie.mediaType,
      originCountry: null,
      overview: movie.overview,
      posterImageUrl: parseImagePath(config.secureBaseUrl, config.posterSizes[posterImageSizeIndex], movie.posterPath),
      backdropImageUrl: parseImagePath(config.secureBaseUrl, config.backdropSizes[backdropImageSizeIndex], movie.backdropPath),
      releaseOrFirstAirDate: movie.releaseDate,
      titleOrName: movie.title,
      voteAverage: movie.voteAverage,
    )).toList();
  }

  static fromTvShowsKnownFor(TMDBImageConfiguration config, List<TVShowBrief> tvShows) {
    return tvShows.map((tvShow) => AppearsIn(
      id: tvShow.id,
      mediaType: tvShow.mediaType,
      originCountry: tvShow.originCountry,
      overview: tvShow.overview,
      posterImageUrl: parseImagePath(config.secureBaseUrl, config.posterSizes[posterImageSizeIndex], tvShow.posterPath),
      backdropImageUrl: parseImagePath(config.secureBaseUrl, config.backdropSizes[backdropImageSizeIndex], tvShow.backdropPath),
      releaseOrFirstAirDate: tvShow.firstAirDate,
      titleOrName: tvShow.name,
      voteAverage: tvShow.voteAverage,
    )).toList();
  }
}
