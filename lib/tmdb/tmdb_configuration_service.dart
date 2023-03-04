import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_image_configuration.dart';

class TMDBConfigurationService {
  final http.Client client;

  TMDBConfigurationService(this.client);

  Future<TMDBImageConfiguration> fetchImageConfiguration() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final response = await client.get(Uri.parse('https://api.themoviedb.org/3/configuration?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dynamic data = jsonData['images'];
      final configuration = TMDBImageConfiguration.fromJson(data);
      return configuration;
    } else {
      throw Exception('Failed to load TMDB configuration');
    }
  }
}