import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({
    Key? key,
    required this.imageUrl})
      : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: BoxFit.cover,
      repeat: ImageRepeat.noRepeat,
      color: Colors.blue,
      colorBlendMode: BlendMode.darken,
      imageBuilder: (context, imageProvider) => FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    );
  }
}
