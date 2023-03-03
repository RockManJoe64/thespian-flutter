import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thespian/tmdb/tmdb_person.dart';

class TMDBPersonService {
  Future<List<TMDBPerson>> fetchPopularPeople() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/person/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['results'];
      final people = data.map((item) => TMDBPerson.fromJson(item)).toList();
      return people;
    } else {
      throw Exception('Failed to load popular actors');
    }
  }
}
