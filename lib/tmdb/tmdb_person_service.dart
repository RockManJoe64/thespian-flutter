import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_popular_person.dart';

class TMDBPersonService {
  final http.Client client;

  TMDBPersonService(this.client);

  Future<List<TMDBPopularPerson>> fetchPopularPeople({int page = 1}) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final response = await client.get(Uri.parse('https://api.themoviedb.org/3/person/popular?page=$page&api_key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBPopularPerson.fromJson(item)).toList();
      return people;
    } else {
      throw Exception('Failed to load popular actors');
    }
  }
}
