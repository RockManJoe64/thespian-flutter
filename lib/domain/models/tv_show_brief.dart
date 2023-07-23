class TVShowBrief {
  final String backdropPath;
  final DateTime firstAirDate;
  final List<int> genreIds;
  final int id;
  final String mediaType;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TVShowBrief({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });
}
