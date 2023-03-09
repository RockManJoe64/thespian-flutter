import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_popular_person.dart';

final imageConfig = TMDBImageConfiguration(
  backdropSizes: [],
  baseUrl: 'http://image.tmdb.org/t/p/',
  logoSizes: [],
  posterSizes: [],
  profileSizes: [
    'w45',
    'w185',
    'h632',
    'original',
  ],
  secureBaseUrl: 'https://image.tmdb.org/t/p/',
  stillSizes: [],
);

final popularPersons = [
  const TMDBPopularPerson(
    knownFor: [
      KnownFor(
        id: 0,
        mediaType: 'movie',
        originCountry: ['US'],
        overview: 'overview',
        posterPath: '/posterPath',
        releaseDate: '2020-01-01',
        title: 'title',
      ),
    ],
    popularity: 0,
    adult: false,
    id: 0,
    name: 'name',
    page: 1,
    profilePath: '/profilePath',
  )
];
