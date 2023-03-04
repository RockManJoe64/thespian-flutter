import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class ActorGridImage extends StatelessWidget {
  final String imageUrl;

  const ActorGridImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fadeInDuration: const Duration(milliseconds: 500),
      fadeOutDuration: const Duration(milliseconds: 500),
      fit: BoxFit.cover,
      width: 200,
      height: 200,
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
