import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  final client = http.Client();
  getIt.registerSingleton<TMDBPersonService>(TMDBPersonService(client));
  getIt.registerSingleton<TMDBConfigurationService>(TMDBConfigurationService(client));
  getIt.registerSingleton<TMDBSearchService>(TMDBSearchService(client));
}
