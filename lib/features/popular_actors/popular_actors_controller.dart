import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thespian/models/popular_actor.dart';
import 'package:thespian/models/transformers.dart';
import 'package:thespian/services/service_locator.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';

class PopularActorsGridViewController extends GetxController {
  final _popularActors = <PopularActor>[].obs;
  UnmodifiableListView<PopularActor> get popularActors => UnmodifiableListView(_popularActors);

  final ScrollController scrollController = ScrollController();

  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  int _currentPage = 1;
  TMDBImageConfiguration? _imageConfiguration;

  PopularActorsGridViewController();

  @override
  void onInit() {
    super.onInit();
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

    final converted = convertToPopularActors(_imageConfiguration!, response);
    _popularActors.addAll(converted);
  }
}
