import 'package:thespian/domain/models/actor.dart';
import 'package:thespian/domain/models/actor_brief.dart';
import 'package:thespian/mappers/person_transformer.dart';
import 'package:thespian/service_locator.dart';
import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

import 'actor_repository.dart';

class TmdbActorRepository implements ActorRepository {
  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBSearchService _tmdbSearchService = getIt<TMDBSearchService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  TMDBImageConfiguration? _imageConfiguration;

  @override
  Future<List<ActorBrief>> fetchPopularActors() async {
    _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbPersonService.fetchPopularPeople();
    final dataModels = mapPersonsToActorBriefs(response);
    return dataModels;
  }

  @override
  Future<List<Actor>> fetchTrendingActors() {
    // TODO: implement fetchTrendingActors
    throw UnimplementedError();
  }

  @override
  Future<List<Actor>> searchActors(String query) {
    // TODO: implement searchActors
    throw UnimplementedError();
  }
}
