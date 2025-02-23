import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/fetch_data_exception.dart';
import 'package:thespian/tmdb/models/tmdb_person.dart';
import 'package:thespian/tmdb/models/tmdb_trending_person.dart';
import 'package:thespian/tmdb/tmdb_authentication.dart';

class TMDBPersonService {
  final http.Client client;

  TMDBPersonService(this.client);

  Future<List<TMDBPerson>> fetchPopularPeople({int page = 1}) async {
    final headers = getAuthenticatedHeaders();
    final queryParameters = {'page': page.toString()};
    final uri = Uri.https('api.themoviedb.org', '3/person/popular', queryParameters);
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBPerson.fromJson(item)).toList();
      return people;
    } else {
      throw FetchDataException('Failed to load popular people');
    }
  }

  Future<List<TMDBTrendingPerson>> fetchTrendingPeople() async {
    final headers = getAuthenticatedHeaders();
    final uri = Uri.https('api.themoviedb.org', '3/trending/person/day');
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBTrendingPerson.fromJson(item)).toList();
      return people;
    } else {
      throw FetchDataException('Failed to load trending people');
    }
  }
}
