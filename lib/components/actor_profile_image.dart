import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class ActorProfileImage extends StatelessWidget {
  const ActorProfileImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height})
      : super(key: key);

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: BoxFit.cover,
      width: width,
      height: height,
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
