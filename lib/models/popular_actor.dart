
class PopularActor {
  int id;
  String name;
  double popularity;
  String smallProfileImageUrl;
  String largeProfileImageUrl;
  List<AppearsIn> appearsIn;

  PopularActor({
    required this.id,
    required this.name,
    required this.popularity,
    required this.smallProfileImageUrl,
    required this.largeProfileImageUrl,
    required this.appearsIn,
  });
}

class AppearsIn {
  int? id;
  String? mediaType;
  List<String>? originCountry;
  String? overview;
  String? posterPath;
  DateTime? releaseOrFirstAirDate;
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
