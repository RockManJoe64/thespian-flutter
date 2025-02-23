import 'package:thespian/domain/models/actor.dart';
import 'package:thespian/domain/models/movie_brief.dart';
import 'package:thespian/domain/models/tv_show_brief.dart';

class ActorBrief {
  final Actor actor;
  final List<MovieBrief>? moviesKnownFor;
  final List<TVShowBrief>? tvShowsKnownFor;

  ActorBrief({required this.actor, this.moviesKnownFor, this.tvShowsKnownFor});
}
