import 'package:thespian/domain/models/actor.dart';
import 'package:thespian/domain/models/actor_brief.dart';

abstract class ActorRepository {
  Future<List<ActorBrief>> fetchPopularActors();

  Future<List<Actor>> fetchTrendingActors();

  Future<List<Actor>> searchActors(String query);
}
