import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:thespian/mappers/person_transformer.dart';
import 'package:thespian/service_locator.dart';
import 'package:thespian/domain/view_models/popular_actor_view_model.dart';
import 'package:thespian/tmdb/fetch_data_exception.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';

class PopularActorsGridViewController extends ChangeNotifier {
  final _popularActors = <PopularActor>[];
  final ScrollController scrollController = ScrollController();
  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  TMDBImageConfiguration? _imageConfiguration;
  int _currentPage = 1;
  String _errorMessage = '';

  // Public properties
  UnmodifiableListView<PopularActor> get popularActors => UnmodifiableListView(_popularActors);
  String get errorMessage => _errorMessage;

  PopularActorsGridViewController() {
    _fetchPopularActors();
    scrollController.addListener(_scrollListener);
  }

  void tryAgain() {
    _popularActors.clear();
    _currentPage = 1;
    _fetchPopularActors();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _currentPage++;
      _fetchPopularActors(page: _currentPage);
    }
  }

  void _fetchPopularActors({int page = 1}) async {
    _errorMessage = '';
    try {
      _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
      final response = await _tmdbPersonService.fetchPopularPeople(page: page);
      final dataModels = mapPopularPersonToActorBriefs(response);
      final viewModels = dataModels.map<PopularActor>((dataModel) =>
          PopularActor.fromActorBrief(_imageConfiguration!, dataModel))
          .toList();
      _popularActors.addAll(viewModels);
    } on FetchDataException catch (_) {
      _errorMessage = "Unfortunately, we couldn't load the actors. Please try again.";
    } catch (e) {
      _errorMessage = "Oops! Something broke. Please try again.";
    } finally {
      notifyListeners();
    }
  }
}
