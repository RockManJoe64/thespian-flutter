import 'package:thespian/tmdb/models/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/models/tmdb_known_for.dart';
import 'package:thespian/tmdb/models/tmdb_person.dart';

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
  const TMDBPerson(
    adult: false,
    gender: 1,
    id: 0,
    knownFor: [
      TmdbKnownFor(
        adult: false,
        backdropPath: '/backdropPath',
        genreIds: [0, 1],
        hasVideo: false,
        id: 0,
        mediaType: 'movie',
        originalLanguage: 'en',
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 100,
        posterPath: '/posterPath',
        releaseDate: '2020-01-01',
        title: 'title',
        voteAverage: 8.2,
        voteCount: 100,
      ),
      TmdbKnownFor(
        adult: false,
        backdropPath: '/backdropPath',
        genreIds: [0, 1],
        hasVideo: false,
        id: 0,
        mediaType: 'tv',
        originalLanguage: 'en',
        originalName: 'originalName',
        originCountry: ['US'],
        overview: 'overview',
        popularity: 100,
        posterPath: '/posterPath',
        firstAirDate: '2020-01-01',
        name: 'name',
        voteAverage: 8.2,
        voteCount: 100,
      ),
    ],
    knownForDepartment: 'acting',
    name: 'name',
    profilePath: '/profilePath',
  )
];
