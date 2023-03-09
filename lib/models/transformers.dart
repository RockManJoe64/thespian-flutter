import 'package:thespian/models/popular_actor.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_popular_person.dart';

var _defaultDateTime = DateTime(1900, 1, 1);
const defaultIntValue = -1;
const defaultName = 'No Name';

/// Convert a [String] to a [DateTime].
DateTime? parseDateTime(String? value) =>
    value != null ? DateTime.parse(value) : null;

/// Convert a [TMDBPopularPerson] to a [PopularActor].
String parseProfilePath(
    String basePath, List<String> profileSizes, String? profilePath) {
  if (profilePath?.isNotEmpty ?? false) {
    final baseUrl = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;
    final profileImage = (profilePath ?? '').replaceAll('/', '');
    final width = profileSizes[1];
    return '$baseUrl/$width/$profileImage';
  }

  return '';
}

/// Convert a list of [KnownFor] to a list of [AppearsIn], sorted by release date.
List<AppearsIn> _convertToAppearsIn(List<KnownFor> knownFor) => knownFor
    .where((k) =>
        k.id != null &&
        ((k.title?.isNotEmpty ?? false) || (k.name?.isNotEmpty ?? false)))
    .map<AppearsIn>((k) => AppearsIn(
        id: k.id,
        mediaType: k.mediaType,
        originCountry: k.originCountry,
        overview: k.overview,
        posterPath: k.posterPath,
        releaseOrFirstAirDate: parseDateTime(k.releaseDate ?? k.firstAirDate),
        titleOrName: k.title ?? k.name))
    .toList()
  ..sort((a, b) => (b.releaseOrFirstAirDate ?? _defaultDateTime)
      .compareTo(a.releaseOrFirstAirDate ?? _defaultDateTime));

/// Convert a list of [TMDBPopularPerson] to a list of [PopularActor], sorted by popularity.
List<PopularActor> convertToPopularActors(
        TMDBImageConfiguration config, List<TMDBPopularPerson> people) =>
    people
        .where((p) =>
            p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
        .map<PopularActor>((p) => PopularActor(
            id: p.id ?? defaultIntValue,
            name: p.name ?? defaultName,
            profileImageUrl: parseProfilePath(
                config.secureBaseUrl, config.profileSizes, p.profilePath),
            popularity: p.popularity ?? 0,
            appearsIn: _convertToAppearsIn(p.knownFor ?? [])))
        .toList()
      ..sort((a, b) => b.popularity.compareTo(a.popularity));
