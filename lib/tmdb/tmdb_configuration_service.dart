import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_authentication.dart';

import 'fetch_data_exception.dart';

class TMDBConfigurationService {
  final http.Client client;

  TMDBConfigurationService(this.client);

  Future<TMDBImageConfiguration> fetchImageConfiguration() async {
    final headers = getAuthenticatedHeaders();
    final uri = Uri.https('api.themoviedb.org', '3/configuration');
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dynamic data = jsonData['images'];
      final configuration = TMDBImageConfiguration.fromJson(data);
      return configuration;
    } else {
      throw FetchDataException('Failed to load TMDB configuration');
    }
  }
}
