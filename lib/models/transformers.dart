import 'package:thespian/models/actor.dart';
import 'package:thespian/models/gender.dart';
import 'package:thespian/tmdb/tmdb_person.dart';

const defaultDateTime = '1900-01-01';
const defaultIntValue = -1;
const defaultName = 'No Name';

parseDateTime(String? value) => value != null ? DateTime.parse(value) : null;

List<Actor> convertToActors(List<TMDBPerson> people) => people
    .map<Actor>((p) => Actor(
          gender: genderFromInt(p.gender ?? defaultIntValue),
          id: p.id ?? defaultIntValue,
          name: p.name ?? defaultName,
          profileImageUrl: p.profilePath ?? '',
          biography: p.biography,
          birthday: parseDateTime(p.birthday),
          deathday: parseDateTime(p.deathday),
          homepage: p.homepage,
          imdbId: p.imdbId,
          placeOfBirth: p.placeOfBirth,
          popularity: p.popularity ?? 0,
        ))
    .toList();
