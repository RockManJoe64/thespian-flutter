class ImageConfiguration {
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;
  final String defaultBackdropSize = 'w780';
  final String defaultLogoSize = 'w45';
  final String defaultPosterSize = 'w185';
  final String defaultProfileSize = 'w185';
  final String defaultStillSize = 'w185';

  ImageConfiguration({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });
}
