import 'package:flutter_test/flutter_test.dart';
import 'package:thespian/models/transformers.dart';

import 'model_mocks.dart';

void main() {
  group('transformers', () {
    test('convertToPopularActors', () {
      // Arrange
      // Act
      var result = convertToPopularActors(imageConfig, popularPersons);

      // Assert
      expect(result, isNotEmpty);
      expect(result.first.id, 0);
      expect(result.first.name, 'name');
      expect(result.first.profileImageUrl,
          'https://image.tmdb.org/t/p/w185/profilePath');
      expect(result.first.popularity, 0);
      expect(result.first.appearsIn, isNotEmpty);
      expect(result.first.appearsIn.first.id, 0);
      expect(result.first.appearsIn.first.mediaType, 'movie');
      expect(result.first.appearsIn.first.originCountry, ['US']);
      expect(result.first.appearsIn.first.overview, 'overview');
      expect(result.first.appearsIn.first.posterPath, '/posterPath');
      expect(result.first.appearsIn.first.releaseOrFirstAirDate, DateTime(2020, 1, 1));
      expect(result.first.appearsIn.first.titleOrName, 'title');
    });
  });
}
