import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';

import 'tmdb_mocks.dart';
import 'tmdb_person_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  dotenv.testLoad(fileInput: '''TMDB_API_KEY=1234
''');
  group('fetchPopularPeople', () {
    test('returns a list of actors', () async {
      // Arrange
      final client = MockClient();
      when(client.get(Uri.parse('https://api.themoviedb.org/3/person/popular?page=1&api_key=1234')))
          .thenAnswer((_) async => http.Response(jsonEncode(popularPersonResponseBody), 200));

      final service = TMDBPersonService(client);

      // Act
      final actors = await service.fetchPopularPeople();

      // Assert
      expect(actors.length, 2);
      expect(actors[0].id, 1);
      expect(actors[0].name, 'Actor 1');
      expect(actors[0].profilePath, '/path/to/profile1.jpg');
      expect(actors[0].knownFor, isNotNull);
      expect(actors[0].knownFor?.length, 2);
      expect(actors[0].knownFor?[0].mediaType, 'movie');
      expect(actors[0].knownFor?[0].releaseDate, '2021-01-01');
      expect(actors[0].knownFor?[0].firstAirDate, isNull);
      expect(actors[1].id, 2);
      expect(actors[1].name, 'Actor 2');
      expect(actors[1].profilePath, '/path/to/profile2.jpg');
      expect(actors[1].knownFor, isNotNull);
      expect(actors[1].knownFor?.length, 2);
      expect(actors[1].knownFor?[0].mediaType, 'tv');
      expect(actors[1].knownFor?[0].releaseDate, isNull);
      expect(actors[1].knownFor?[0].firstAirDate, '2021-01-01');
    });

    test('throws an exception if the API call fails', () async {
      // Arrange
      final client = MockClient();
      final service = TMDBPersonService(client);
      when(client.get(Uri.parse('https://api.themoviedb.org/3/person/popular?page=1&api_key=1234')))
          .thenAnswer((_) async => http.Response('Failed to load popular actors', 500));

      // Act, Assert
      expect(() => service.fetchPopularPeople(), throwsException);
    });
  });
}
