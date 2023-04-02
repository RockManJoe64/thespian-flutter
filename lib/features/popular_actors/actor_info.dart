import 'package:flutter/material.dart';
import 'package:thespian/components/actor_profile_image.dart';
import 'package:thespian/components/backdrop_image.dart';
import 'package:thespian/components/poster_image.dart';
import 'package:thespian/models/popular_actor.dart';

class PopularActorInfo extends StatelessWidget {
  const PopularActorInfo({Key? key, required this.popularActor}) : super(key: key);

  final PopularActor popularActor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(popularActor.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: ActorProfileImage(imageUrl: popularActor.largeProfileImageUrl, width: 200, height: 300),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: PosterImage(imageUrl: popularActor.appearsIn[0].posterImageUrl!),
                ),
              ),
            ],
          ),
          // This will take up the rest of the space in the column
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Opacity(
                opacity: 0.25,
                child: BackdropImage(imageUrl: popularActor.appearsIn[0].backdropImageUrl!),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: PosterImage(imageUrl: popularActor.appearsIn[1].posterImageUrl!),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: PosterImage(imageUrl: popularActor.appearsIn[2].posterImageUrl!),
                ),
              ),
            ],
          ),
        ],
      ),
      );
  }
}