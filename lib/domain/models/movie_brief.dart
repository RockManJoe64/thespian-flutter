class MovieBrief {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String mediaType;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieBrief({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });
}
