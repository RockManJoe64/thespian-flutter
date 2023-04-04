import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

import 'mock_search_person_results_mock.dart';
import 'tmdb_search_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  dotenv.testLoad(fileInput: '''TMDB_API_KEY=1234
''');
  group('searchPeopleByKeyword', () {
    test('returns a list of actors upon successful search', () async {
      // Arrange
      final client = MockClient();
      when(client.get(Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&api_key=1234&language=en-US&region=US&page=1')))
          .thenAnswer((_) async => http.Response(jsonEncode(searchPersonResponseBody), 200));

      final service = TMDBSearchService(client);

      // Act
      final actors = await service.searchPeopleByKeyword('actor');

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

    test('should return an exception when API returns 401', () async {
      // Arrange
      final client = MockClient();
      when(client.get(Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&api_key=1234&language=en-US&region=US&page=1')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      final service = TMDBSearchService(client);

      // Act
      final call = service.searchPeopleByKeyword('actor');

      // Assert
      expect(call, throwsException);
    });

    test('should return an exception when API returns 404', () async {
      // Arrange
      final client = MockClient();
      when(client.get(Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&api_key=1234&language=en-US&region=US&page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final service = TMDBSearchService(client);

      // Act
      final call = service.searchPeopleByKeyword('actor');

      // Assert
      expect(call, throwsException);
    });
  });
}