import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thespian/tmdb/tmdb_search_service.dart';

import 'data/loaders.dart';
import 'tmdb_search_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  dotenv.testLoad(
    fileInput: '''
TMDB_API_KEY=1234
TMDB_AUTH_TOKEN=5678
''',
  );
  group('searchPeopleByKeyword', () {
    late String responseBody;
    late Map<String, String> headers;

    setUpAll(() async {
      responseBody = await readJsonFile('tmdb_search_person_response.json');
      headers = {
        HttpHeaders.authorizationHeader: 'Bearer 5678',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    });

    test('returns a list of actors upon successful search', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1');
      final client = MockClient();
      when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

      final service = TMDBSearchService(client);

      // Act
      final actors = await service.searchPeopleByKeyword('actor');

      // Assert
      expect(actors.length, 5);
    });

    test('should parse the actor details', () async {
      // Arrange
      final uri = Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1');
      final client = MockClient();
      when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

      final service = TMDBSearchService(client);

      // Act
      final actors = await service.searchPeopleByKeyword('actor');

      // Assert
      final actor = actors[0];
      expect(actor.adult, false);
      expect(actor.gender, 2);
      expect(actor.id, 6384);
      expect(actor.knownForDepartment, 'Acting');
      expect(actor.name, 'Keanu Reeves');
      expect(actor.originalName, 'Keanu Reeves');
      expect(actor.popularity, 99.493);
      expect(actor.profilePath, '/8RZLOyYGsoRe9p44q3xin9QkMHv.jpg');
    });

    group('when the knownFor exists', () {
      test('should parse all knownFor sections', () async {
        // Arrange
        final uri = Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1');
        final client = MockClient();
        when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

        final service = TMDBSearchService(client);

        // Act
        final actors = await service.searchPeopleByKeyword('actor');

        // Assert
        final actor = actors[0];
        expect(actor.knownFor, isNotNull);
        expect(actor.knownFor?.length, 3);
      });

      test('should parse a knownFor movie section', () async {
        // Arrange
        final uri = Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1');
        final client = MockClient();
        when(client.get(uri, headers: headers)).thenAnswer((_) async => http.Response(responseBody, 200));

        final service = TMDBSearchService(client);

        // Act
        final actors = await service.searchPeopleByKeyword('actor');

        // Assert
        final knownFor = actors[0].knownFor![0];
        expect(knownFor.mediaType, 'movie');
        expect(knownFor.releaseDate, '1999-03-31');
        expect(knownFor.firstAirDate, isNull);
        expect(knownFor.backdropPath, '/icmmSD4vTTDKOq2vvdulafOGw93.jpg');
        expect(knownFor.id, 603);
        expect(knownFor.title, 'The Matrix');
        expect(knownFor.originalTitle, 'The Matrix');
        expect(knownFor.overview, isNotEmpty);
        expect(knownFor.posterPath, '/dXNAPwY7VrqMAo51EKhhCJfaGb5.jpg');
        expect(knownFor.adult, false);
        expect(knownFor.originalLanguage, 'en');
        expect(knownFor.genreIds, isNotNull);
        expect(knownFor.popularity, 121.005);
        expect(knownFor.hasVideo, true);
        expect(knownFor.voteAverage, 8.221);
        expect(knownFor.voteCount, 26057);
      });
    });

    test('should return an exception when API returns 401', () async {
      // Arrange
      final client = MockClient();
      when(
        client.get(
          Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1'),
          headers: headers,
        ),
      ).thenAnswer((_) async => http.Response('Unauthorized', 401));

      final service = TMDBSearchService(client);

      // Act
      final call = service.searchPeopleByKeyword('actor');

      // Assert
      expect(call, throwsException);
    });

    test('should return an exception when API returns 404', () async {
      // Arrange
      final client = MockClient();
      when(
        client.get(
          Uri.parse('https://api.themoviedb.org/3/search/person?query=actor&language=en-US&region=US&page=1'),
          headers: headers,
        ),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      final service = TMDBSearchService(client);

      // Act
      final call = service.searchPeopleByKeyword('actor');

      // Assert
      expect(call, throwsException);
    });
  });
}
