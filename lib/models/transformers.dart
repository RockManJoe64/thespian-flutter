import 'package:thespian/models/popular_actor.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_popular_person.dart';

var _defaultDateTime = DateTime(1900, 1, 1);
const defaultIntValue = -1;
const defaultName = 'No Name';
const smallProfileImageSizeIndex = 1;
const largeProfileImageSizeIndex = 3;
const posterImageSizeIndex = 3;
const backdropImageSizeIndex = 2;

/// Convert a [String] to a [DateTime].
DateTime? _parseDateTime(String? value) =>
    value != null ? DateTime.parse(value) : null;

/// Returns the full URL for a profile image.
String _parseImagePath(
    String basePath, String size, String? profilePath) {
  if (profilePath?.isNotEmpty ?? false) {
    final baseUrl = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;
    final profileImage = (profilePath ?? '').replaceAll('/', '');
    return '$baseUrl/$size/$profileImage';
  }
  return '';
}

/// Convert a list of [KnownFor] to a list of [AppearsIn], sorted by popularity.
List<AppearsIn> _convertToAppearsIn(TMDBImageConfiguration config, List<KnownFor> knownFor) => knownFor
    .where((k) =>
        k.id != null &&
        ((k.title?.isNotEmpty ?? false) || (k.name?.isNotEmpty ?? false)))
    .map<AppearsIn>((k) => AppearsIn(
        id: k.id!,
        mediaType: k.mediaType!,
        originCountry: k.originCountry,
        overview: k.overview!,
        posterImageUrl: _parseImagePath(config.secureBaseUrl, config.posterSizes[posterImageSizeIndex], k.posterPath),
        backdropImageUrl: _parseImagePath(config.secureBaseUrl, config.backdropSizes[backdropImageSizeIndex], k.backdropPath),
        releaseOrFirstAirDate: _parseDateTime(k.releaseDate ?? k.firstAirDate),
        titleOrName: (k.title ?? k.name)!,
        voteAverage: k.voteAverage ?? 0))
    .toList()
  ..sort((a, b) => b.voteAverage.compareTo(a.voteAverage));

/// Convert a list of [TMDBPopularPerson] to a list of [PopularActor], sorted by popularity.
List<PopularActor> convertToPopularActors(
        TMDBImageConfiguration config, List<TMDBPopularPerson> people) =>
    people
        .where((p) =>
            p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
        .map<PopularActor>((p) => PopularActor(
            id: p.id ?? defaultIntValue,
            name: p.name ?? defaultName,
            smallProfileImageUrl: _parseImagePath(
                config.secureBaseUrl, config.profileSizes[smallProfileImageSizeIndex], p.profilePath), // 0: w45, 1: w185, 2: h632, 3: original
            largeProfileImageUrl: _parseImagePath(
                config.secureBaseUrl, config.profileSizes[largeProfileImageSizeIndex], p.profilePath),
            popularity: p.popularity ?? 0,
            appearsIn: _convertToAppearsIn(config, p.knownFor ?? [])))
        .toList()
      ..sort((a, b) => b.popularity.compareTo(a.popularity));
