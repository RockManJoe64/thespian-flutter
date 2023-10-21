import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/models/tmdb_person.dart';

class TMDBPersonService {
  final http.Client client;

  TMDBPersonService(this.client);

  Future<List<TMDBPerson>> fetchPopularPeople({int page = 1}) async {
    final apiKey = dotenv.env['TMDB_AUTH_TOKEN'];
    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/person/popular?page=$page'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          HttpHeaders.acceptHeader: 'application/json',
        });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBPerson.fromJson(item)).toList();
      return people;
    } else {
      throw Exception('Failed to load popular people');
    }
  }

  Future<List<TMDBPerson>> fetchTrendingPeople({int page = 1}) async {
    final apiKey = dotenv.env['TMDB_AUTH_TOKEN'];
    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/trending/person/day?page=$page'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          HttpHeaders.acceptHeader: 'application/json',
        });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBPerson.fromJson(item)).toList();
      return people;
    } else {
      throw Exception('Failed to load trending people');
    }
  }
}
