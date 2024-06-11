import 'package:flutter/material.dart';
import 'package:thespian/components/actor_profile_image.dart';
import 'package:thespian/components/backdrop_image.dart';
import 'package:thespian/components/poster_image.dart';
import 'package:thespian/domain/view_models/popular_actor_view_model.dart';

const badUrl = "https://foobar.com";

class PopularActorInfo extends StatelessWidget {
  const PopularActorInfo({super.key, required this.popularActor});

  final PopularActor popularActor;

  List<String> _getPosterImageUrls() {
    var appearsIn = popularActor.appearsIn;
    var posterImageUrls = appearsIn.map((e) => e.posterImageUrl)
        .toList();
    posterImageUrls.addAll([badUrl, badUrl, badUrl]);
    posterImageUrls = posterImageUrls.sublist(0, 3);
    return posterImageUrls;
  }

  @override
  Widget build(BuildContext context) {
    var appearsIn = popularActor.appearsIn;
    var backdropImageUrl = appearsIn.isNotEmpty ? appearsIn[0].backdropImageUrl : badUrl;
    var posterImageUrls = _getPosterImageUrls();
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
                  child: PosterImage(imageUrl: posterImageUrls.isNotEmpty ? posterImageUrls[0] : badUrl),
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
                child: BackdropImage(imageUrl: backdropImageUrl),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: PosterImage(imageUrl: posterImageUrls.isNotEmpty ? posterImageUrls[1] : badUrl),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: PosterImage(imageUrl: posterImageUrls.isNotEmpty ? posterImageUrls[2] : badUrl),
                ),
              ),
            ],
          ),
        ],
      ),
      );
  }
}