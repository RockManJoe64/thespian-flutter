import 'package:thespian/models/actor.dart';
import 'package:thespian/models/gender.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';
import 'package:thespian/tmdb/tmdb_person.dart';

const defaultDateTime = '1900-01-01';
const defaultIntValue = -1;
const defaultName = 'No Name';

DateTime? parseDateTime(String? value) =>
    value != null ? DateTime.parse(value) : null;

String parseProfilePath(
    String basePath, List<String> profileSizes, String? profilePath) {
  if (profilePath?.isNotEmpty ?? false) {
    final profileImage = (profilePath ?? '').replaceAll('/', '');
    final width = profileSizes[1];
    return '$basePath/$width/$profileImage';
  }

  return '';
}

List<Actor> convertToActors(
        TMDBImageConfiguration config, List<TMDBPerson> people) =>
    people
        .where((p) =>
            p.id != null && (p.name?.isNotEmpty ?? false) && p.adult == false)
        .map<Actor>((p) => Actor(
              gender: genderFromInt(p.gender ?? defaultIntValue),
              id: p.id ?? defaultIntValue,
              name: p.name ?? defaultName,
              profileImageUrl: parseProfilePath(
                  config.secureBaseUrl, config.profileSizes, p.profilePath),
              biography: p.biography,
              birthday: parseDateTime(p.birthday),
              deathday: parseDateTime(p.deathday),
              homepage: p.homepage,
              imdbId: p.imdbId,
              placeOfBirth: p.placeOfBirth,
              popularity: p.popularity ?? 0,
            ))
        .toList();
