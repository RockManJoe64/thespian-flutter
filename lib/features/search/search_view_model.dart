import 'package:thespian/common/image_path_utils.dart';
import 'package:thespian/domain/models/search_result.dart';
import 'package:thespian/tmdb/tmdb_image_configuration.dart';

class SearchViewModel {
  int id;
  String name;
  String mediaType;
  String smallImageUrl;
  String largeImageUrl;

  SearchViewModel({
    required this.id,
    required this.name,
    required this.mediaType,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  bool get containsSmallImage => smallImageUrl.isNotEmpty;
  bool get containsLargeImage => largeImageUrl.isNotEmpty;

  static fromSearchResult(TMDBImageConfiguration config, SearchResult searchResult) {
    return SearchViewModel(
      id: searchResult.id,
      name: searchResult.name,
      mediaType: searchResult.mediaType,
      smallImageUrl: parseImagePath(config.secureBaseUrl, config.profileSizes[smallProfileImageSizeIndex], searchResult.imagePath),
      largeImageUrl: parseImagePath(config.secureBaseUrl, config.profileSizes[largeProfileImageSizeIndex], searchResult.imagePath),
    );
  }
}
