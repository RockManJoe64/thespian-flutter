import 'package:flutter_test/flutter_test.dart';
import 'package:thespian/mappers/person_transformer.dart';

import 'model_mocks.dart';

void main() {
  group('transformers', () {
    test('convertToPopularActors', () {
      // Arrange
      // Act
      var result = mapPopularPersonToActorBriefs(popularPersons);

      // Assert
      expect(result, isNotEmpty);
      expect(result.first.id, 0);
      expect(result.first.name, 'name');
      expect(result.first.profilePath, '/profilePath'); // TODO should the forward slash be part of the path?
      expect(result.first.popularity, 0.0);
      expect(result.first.gender, 1);
      // TODO complete test
    });
  });
}
