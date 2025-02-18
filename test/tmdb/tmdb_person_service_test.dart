import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as path;
import 'package:thespian/tmdb/tmdb_person_service.dart';

import 'tmdb_person_service_test.mocks.dart';

Future<String> readJsonFile(String fileName) async {
  final filePath = path.join(Directory.current.path, 'test', 'tmdb', 'data', fileName);
  final file = File(filePath);
  final content = await file.readAsString();
  return content
      .replaceAll('\u2014', '-') // Normalize character 8212 (EM DASH) to hyphen '-'
      .replaceAll(
        '\u2019',
        '\'',
      ); // Normalize character 8217 (RIGHT SINGLE QUOTATION MARK) to apostrophe/single quote '''
}

@GenerateMocks([http.Client])
void main() {
  dotenv.testLoad(
    fileInput: '''
TMDB_API_KEY=1234
TMDB_AUTH_TOKEN=5678
''',
  );

  group('fetchPopularPeople', () {
    late String responseBody;
    late Map<String, String> headers;

    setUpAll(() async {
      responseBody = await readJsonFile('tmdb_popular_person_response.json');
      headers = {
        HttpHeaders.authorizationHeader: 'Bearer 5678',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    });

    test('returns a list of actors', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/person/popular?page=1');
      final client = MockClient();
      when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

      final service = TMDBPersonService(client);

      // Act
      final actors = await service.fetchPopularPeople();

      // Assert
      expect(actors.length, 2);
      expect(actors[0].id, 2786960);
      expect(actors[0].name, 'Gabriel Guevara');
      expect(actors[0].profilePath, '/pviRYKEEmoPUfLYwP1VHJ6LQcRg.jpg');
      expect(actors[0].knownFor, isNotNull);
      expect(actors[0].knownFor?.length, 3);
      expect(actors[0].knownFor?[0].mediaType, 'movie');
      expect(actors[0].knownFor?[0].releaseDate, '2023-06-08');
      expect(actors[0].knownFor?[0].firstAirDate, isNull);
      expect(actors[1].id, 974169);
      expect(actors[1].name, 'Jenna Ortega');
      expect(actors[1].profilePath, '/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg');
      expect(actors[1].knownFor, isNotNull);
      expect(actors[1].knownFor?.length, 3);
      expect(actors[1].knownFor?[0].mediaType, 'tv');
      expect(actors[1].knownFor?[0].releaseDate, isNull);
      expect(actors[1].knownFor?[0].firstAirDate, '2022-11-23');
    });

    test('throws an exception if the API call fails', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/person/popular?page=1');
      final client = MockClient();
      when(
        client.get(uri, headers: headers),
      ).thenAnswer((_) async => http.Response('Failed to load popular actors', 500));

      final service = TMDBPersonService(client);

      // Act, Assert
      expect(() => service.fetchPopularPeople(), throwsException);
    });
  });

  group('fetchTrendingPeople', () {
    late String responseBody;

    setUpAll(() async {
      responseBody = await readJsonFile('tmdb_trending_person_response.json');
    });

    test('returns a list of actors', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/trending/person/day');
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer 5678',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final client = MockClient();
      when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

      final service = TMDBPersonService(client);

      // Act
      final actors = await service.fetchTrendingPeople();

      // Assert
      expect(actors.length, 3);
      expect(actors[0].id, 500);
      expect(actors[0].name, 'Tom Cruise');
      expect(actors[0].profilePath, '/8qBylBsQf4llkGrWR3qAsOtOU8O.jpg');
      expect(actors[0].knownFor, isNull);
      expect(actors[0].popularity, 156.86);
      expect(actors[1].id, 11701);
      expect(actors[1].name, 'Angelina Jolie');
      expect(actors[1].profilePath, '/bXNxIKcJ5cNNW8QFrBPWcfTSu9x.jpg');
      expect(actors[1].knownFor, isNull);
      expect(actors[1].popularity, 75.877);
      expect(actors[2].id, 110);
      expect(actors[2].name, 'Viggo Mortensen');
      expect(actors[2].profilePath, '/vH5gVSpHAMhDaFWfh0Q7BG61O1y.jpg');
      expect(actors[2].knownFor, isNull);
      expect(actors[2].popularity, 37.305);
    });

    test('throws an exception if the API call fails', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/trending/person/day');
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer 5678',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final client = MockClient();
      when(
        client.get(uri, headers: headers),
      ).thenAnswer((_) async => http.Response('Failed to load popular actors', 500));
    });
  });
}
