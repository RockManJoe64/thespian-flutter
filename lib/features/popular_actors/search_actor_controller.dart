import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:thespian/features/popular_actors/popular_actor_view_model.dart';
import 'package:thespian/models/person_transformer.dart';
import 'package:thespian/services/service_locator.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

class SearchActorController extends ChangeNotifier {
  final _actorSearchResults = <PopularActor>[];
  UnmodifiableListView<PopularActor> get actorSearchResults => UnmodifiableListView(_actorSearchResults);

  final searchTextEditingController = TextEditingController();
  final scrollController = ScrollController();

  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBSearchService _tmdbSearchService = getIt<TMDBSearchService>();
  TMDBImageConfiguration? _imageConfiguration;
  int _currentPage = 1;
  String _keyword = '';

  SearchActorController() {
    searchTextEditingController.addListener(_textListener);
    scrollController.addListener(_scrollListener);
  }

  void performSearch(String keyword) {
    if (keyword.isNotEmpty) _keyword = keyword;
    searchAgain();
  }

  void searchAgain() {
    _currentPage = 1;
    _clearResults();
    _performSearch();
  }

  void clear() {
    searchTextEditingController.clear();
    _clearResults();
  }

  void _clearResults() {
    _actorSearchResults.clear();
    notifyListeners();
  }

  void _textListener() {
    const debounceDuration = Duration(milliseconds: 500);
    Future.delayed(debounceDuration, () {
      _keyword = searchTextEditingController.text;
      if (_keyword.isEmpty || _keyword.length < 3) {
        _clearResults();
        return;
      }
      _performSearch();
    });
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      _currentPage++;
      _performSearch(page: _currentPage);
    }
  }

  void _performSearch({int page = 1}) async {
    if (_keyword.isEmpty) {
      _actorSearchResults.clear();
      notifyListeners();
      return;
    }
    _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbSearchService.searchPeopleByKeyword(_keyword, page: page);
    final dataModels = mapPopularPersonToActorBriefs(response, sort: false);
    final viewModels = dataModels.map<PopularActor>((dataModel) =>
        PopularActor.fromActorBrief(_imageConfiguration!, dataModel))
        .where((actor) => actor.containsSmallProfileImage && actor.containsLargeProfileImage)
        .toList();
    if (page == 1) _actorSearchResults.clear();
    _actorSearchResults.addAll(viewModels);
    notifyListeners();
  }
}
