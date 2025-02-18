import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:thespian/domain/models/search_result.dart';
import 'package:thespian/features/popular_actors/popular_actor_view_model.dart';
import 'package:thespian/features/search/popular_actor_transformer.dart';
import 'package:thespian/features/search/search_view_model.dart';
import 'package:thespian/mappers/person_transformer.dart';
import 'package:thespian/mappers/search_transformer.dart';
import 'package:thespian/service_locator.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

class SearchActorController extends ChangeNotifier {
  final _searchViewModels = <SearchViewModel>[];
  final _dataModels = <SearchResult>[];
  UnmodifiableListView<SearchViewModel> get searchResults => UnmodifiableListView(_searchViewModels);

  final searchTextEditingController = TextEditingController();
  final scrollController = ScrollController();

  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBSearchService _tmdbSearchService = getIt<TMDBSearchService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  TMDBImageConfiguration? _imageConfiguration;
  int _currentPage = 1;
  String _keyword = '';

  SearchActorController() {
    _fetchTrendingPeople();
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
    _fetchTrendingPeople();
  }

  /// Returns a [PopularActor] from the [SearchViewModel] with the given [tmdbId].
  /// This is needed to support displaying a Person result using the [PopularActorInfo] widget.
  PopularActor toPopularActor(SearchViewModel searchViewModel) {
    final searchResult = _dataModels.firstWhere((dataModel) => dataModel.id == searchViewModel.id);
    return mapToPopularActor(_imageConfiguration!, searchResult);
  }

  void _clearResults() {
    _dataModels.clear();
    _searchViewModels.clear();
    notifyListeners();
  }

  void _textListener() {
    const debounceDuration = Duration(milliseconds: 500);
    Future.delayed(debounceDuration, () {
      _keyword = searchTextEditingController.text;
      // if (_keyword.isEmpty || _keyword.length < 3) {
      //   _clearResults();
      //   return;
      // }
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
      _searchViewModels.clear();
      notifyListeners();
      return;
    }
    _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbSearchService.searchAnyByKeyword(_keyword, page: page);
    final dataModels = mapToSearchResults(response, sort: false);
    final viewModels = dataModels.map<SearchViewModel>((dataModel) =>
        SearchViewModel.fromSearchResult(_imageConfiguration!, dataModel))
        .where((searchResult) => searchResult.containsSmallImage && searchResult.containsLargeImage)
        .toList();
    if (page == 1) {
      _dataModels.clear();
      _searchViewModels.clear();
    }
    _dataModels.addAll(dataModels);
    _searchViewModels.addAll(viewModels);
    notifyListeners();
  }

  void _fetchTrendingPeople() async {
    _imageConfiguration ??= await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbPersonService.fetchTrendingPeople();
    final dataModels = mapPopularPersonToActorBriefs(response);
    final viewModels = dataModels.map<SearchViewModel>((dataModel) =>
        SearchViewModel.fromActorBrief(_imageConfiguration!, dataModel))
        .where((searchResult) => searchResult.containsSmallImage && searchResult.containsLargeImage)
        .toList();
    _dataModels.clear();
    _dataModels.addAll(mapFromActorBriefs(dataModels));
    _searchViewModels.clear();
    _searchViewModels.addAll(viewModels);
    notifyListeners();
  }
}
