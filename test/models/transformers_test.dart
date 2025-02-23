import 'package:flutter_test/flutter_test.dart';
import 'package:thespian/domain/models/gender.dart';
import 'package:thespian/mappers/person_transformer.dart';

import 'model_mocks.dart';

void main() {
  group('transformers', () {
    test('convertToPopularActors', () {
      // Arrange
      // Act
      var result = mapPersonsToActorBriefs(popularPersons);

      // Assert
      expect(result, isNotEmpty);
      expect(result.first.actor.tmdbId, 0);
      expect(result.first.actor.name, 'name');
      expect(result.first.actor.profileImageUrl, '/profilePath'); // TODO should the forward slash be part of the path?
      expect(result.first.actor.popularity, 0.0);
      expect(result.first.actor.gender, Gender.female);
      // TODO complete test
    });
  });
}
