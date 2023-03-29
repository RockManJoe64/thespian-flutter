import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thespian/models/popular_actor.dart';
import 'package:transparent_image/transparent_image.dart';

class PopularActorInfo extends StatelessWidget {
  const PopularActorInfo({Key? key, required this.popularActor}) : super(key: key);

  final PopularActor popularActor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(popularActor.name),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: 'ActorProfileImage',
          child: CachedNetworkImage(
            imageUrl: popularActor.profileImageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fadeInDuration: const Duration(milliseconds: 500),
            fadeOutDuration: const Duration(milliseconds: 500),
            fit: BoxFit.cover,
            width: 200,
            height: 300,
            repeat: ImageRepeat.noRepeat,
            color: Colors.blue,
            colorBlendMode: BlendMode.darken,
            imageBuilder: (context, imageProvider) => FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      )
    );
  }
}