import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_person_search_result.dart';

class TMDBSearchService {
  TMDBSearchService(this.client);

  final http.Client client;

  Future<List<TMDBPersonSearchResult>> searchPeopleByKeyword(String keyword) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final queryParameters = {
      'query': keyword,
      'api_key': apiKey,
      'language': 'en-US',
      'region': 'US',
      'page': '1',
    };
    final uri = Uri.https('api.themoviedb.org', '3/search/person', queryParameters);
    final response = await client.get(Uri.parse(uri.toString()));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      return data.map((e) => TMDBPersonSearchResult.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search people by keyword');
    }
  }
}