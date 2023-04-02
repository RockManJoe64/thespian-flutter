
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
  int id;
  String mediaType;
  List<String>? originCountry;
  String overview;
  String posterImageUrl;
  String backdropImageUrl;
  DateTime? releaseOrFirstAirDate;
  String titleOrName;
  double voteAverage;

  AppearsIn({
    required this.id,
    required this.mediaType,
    this.originCountry,
    required this.overview,
    required this.posterImageUrl,
    required this.backdropImageUrl,
    this.releaseOrFirstAirDate,
    required this.titleOrName,
    required this.voteAverage,
  });
}
