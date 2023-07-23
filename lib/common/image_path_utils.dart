const smallProfileImageSizeIndex = 1;
const largeProfileImageSizeIndex = 3;
const posterImageSizeIndex = 3;
const backdropImageSizeIndex = 2;

/// Returns the full URL for a profile image.
String parseImagePath(
    String basePath, String size, String? imagePath) {
  if (imagePath?.isNotEmpty ?? false) {
    final baseUrl = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;
    final profileImage = (imagePath ?? '').replaceAll('/', '');
    return '$baseUrl/$size/$profileImage';
  }
  return '';
}