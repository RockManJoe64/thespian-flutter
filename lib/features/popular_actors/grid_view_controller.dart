import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:thespian/models/popular_person_transformers.dart';
import 'package:thespian/services/service_locator.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';

import 'popular_actor_view_model.dart';

class PopularActorsGridViewController extends ChangeNotifier {
  final _popularActors = <PopularActor>[];
  UnmodifiableListView<PopularActor> get popularActors => UnmodifiableListView(_popularActors);

  final ScrollController scrollController = ScrollController();

  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  int _currentPage = 1;
  TMDBImageConfiguration? _imageConfiguration;

  PopularActorsGridViewController() {
    _fetchPopularActors();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _currentPage++;
      _fetchPopularActors(page: _currentPage);
    }
  }

  void _fetchPopularActors({int page = 1}) async {
    _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbPersonService.fetchPopularPeople(page: page);
    final dataModels = mapPopularPersonToActorBriefs(response);
    final viewModels = dataModels.map<PopularActor>((dataModel) =>
        PopularActor.fromActorBrief(_imageConfiguration!, dataModel))
        .toList();
    _popularActors.addAll(viewModels);
    notifyListeners();
  }
}
