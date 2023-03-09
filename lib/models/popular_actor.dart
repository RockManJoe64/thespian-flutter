
class PopularActor {
  int id;
  String name;
  double popularity;
  String profileImageUrl;
  List<AppearsIn> appearsIn;

  PopularActor({
    required this.id,
    required this.name,
    required this.popularity,
    required this.profileImageUrl,
    required this.appearsIn,
  });
}

class AppearsIn {
  int? id;
  String? mediaType;
  List<String>? originCountry;
  String? overview;
  String? posterPath;
  String? releaseOrFirstAirDate;
  String? titleOrName;

  AppearsIn({
    this.id,
    this.mediaType,
    this.originCountry,
    this.overview,
    this.posterPath,
    this.releaseOrFirstAirDate,
    this.titleOrName,
  });
}
