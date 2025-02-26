import 'package:thespian/domain/models/actor_brief.dart';
import 'package:thespian/domain/models/movie_brief.dart';
import 'package:thespian/domain/models/tv_show_brief.dart';

class SearchResult {
  final int id;
  final String name;
  final String imagePath;
  final String mediaType;
  ActorBrief? actorBrief;
  MovieBrief? movieBrief;
  TVShowBrief? tvShowBrief;

  SearchResult({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.mediaType,
    this.actorBrief,
    this.movieBrief,
    this.tvShowBrief,
  });
}
