import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/fetch_data_exception.dart';
import 'package:thespian/tmdb/models/tmdb_person.dart';
import 'package:thespian/tmdb/models/tmdb_search_result.dart';
import 'package:thespian/tmdb/tmdb_authentication.dart';

class TMDBSearchService {
  TMDBSearchService(this.client);

  final http.Client client;

  Future<List<TMDBPerson>> searchPeopleByKeyword(String keyword, {int page = 1}) async {
    assert(page > 0);
    final headers = getAuthenticatedHeaders();
    final queryParameters = {'query': keyword, 'language': 'en-US', 'region': 'US', 'page': page.toString()};
    final uri = Uri.https('api.themoviedb.org', '3/search/person', queryParameters);
    final response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      return data.map((e) => TMDBPerson.fromJson(e)).toList();
    } else {
      throw FetchDataException('Failed to search people by keyword');
    }
  }

  Future<List<TMDBSearchResult>> searchAnyByKeyword(String keyword, {int page = 1}) async {
    assert(page > 0);
    final headers = getAuthenticatedHeaders();
    final queryParameters = {'query': keyword, 'language': 'en-US', 'region': 'US', 'page': page.toString()};
    final uri = Uri.https('api.themoviedb.org', '3/search/multi', queryParameters);
    final response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      return data.map((e) => TMDBSearchResult.fromJson(e)).toList();
    } else {
      throw FetchDataException('Failed to search by keyword');
    }
  }
}
