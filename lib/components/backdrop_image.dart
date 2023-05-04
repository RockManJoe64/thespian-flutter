import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class BackdropImage extends StatelessWidget {
  const BackdropImage({
    Key? key,
    required this.imageUrl,
    this.opacity = 1.0,})
      : super(key: key);

  final String imageUrl;
  final double opacity;

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
      color: Color.fromRGBO(255, 255, 255, opacity),
      colorBlendMode: BlendMode.modulate,
      imageBuilder: (context, imageProvider) => FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    );
  }
}
