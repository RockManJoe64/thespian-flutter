import 'movie_brief.dart';
import 'tv_show_brief.dart';

class ActorBrief {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String profilePath;
  final List<MovieBrief>? moviesKnownFor;
  final List<TVShowBrief>? tvShowsKnownFor;

  ActorBrief({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
    this.moviesKnownFor,
    this.tvShowsKnownFor,
  });
}
