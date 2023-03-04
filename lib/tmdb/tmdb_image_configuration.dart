import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_image_configuration.freezed.dart';
part 'tmdb_image_configuration.g.dart';

@freezed
class TMDBImageConfiguration with _$TMDBImageConfiguration {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory TMDBImageConfiguration({
    required String baseUrl,
    required String secureBaseUrl,
    required List<String> backdropSizes,
    required List<String> logoSizes,
    required List<String> posterSizes,
    required List<String> profileSizes,
    required List<String> stillSizes,
  }) = _TMDBConfiguration;

  factory TMDBImageConfiguration.fromJson(Map<String, dynamic> json) =>
      _$TMDBImageConfigurationFromJson(json);
}
