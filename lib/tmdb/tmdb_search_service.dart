import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_person.dart';
import 'package:thespian/tmdb/tmdb_search_result.dart';

class TMDBSearchService {
  TMDBSearchService(this.client);

  final http.Client client;

  Future<List<TMDBPerson>> searchPeopleByKeyword(String keyword, {int page = 1}) async {
    assert(page > 0);
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final queryParameters = {
      'query': keyword,
      'api_key': apiKey,
      'language': 'en-US',
      'region': 'US',
      'page': page.toString(),
    };
    final uri = Uri.https('api.themoviedb.org', '3/search/person', queryParameters);
    final response = await client.get(Uri.parse(uri.toString()));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      return data.map((e) => TMDBPerson.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search people by keyword');
    }
  }

  Future<List<TMDBSearchResult>> searchAnyByKeyword(String keyword, {int page = 1}) async {
    assert(page > 0);
    final authToken = dotenv.env['TMDB_AUTH_TOKEN'];
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $authToken'};
    final queryParameters = {
      'query': keyword,
      'language': 'en-US',
      'region': 'US',
      'page': page.toString(),
    };
    final uri = Uri.https('api.themoviedb.org', '3/search/multi', queryParameters);
    final response = await client.get(Uri.parse(uri.toString()), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      return data.map((e) => TMDBSearchResult.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search by keyword');
    }
  }
}
