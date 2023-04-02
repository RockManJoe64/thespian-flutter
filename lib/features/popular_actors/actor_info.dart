import 'package:flutter/material.dart';
import 'package:thespian/components/actor_profile_image.dart';
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
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: ActorProfileImage(imageUrl: popularActor.largeProfileImageUrl, width: 200, height: 200),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(popularActor.name),
                        Text(popularActor.popularity.toString()),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: popularActor.appearsIn.length,
                  itemBuilder: (context, index) {
                    final appearsIn = popularActor.appearsIn[index];
                    return ListTile(
                      title: Text(appearsIn.titleOrName!),
                      subtitle: Text(appearsIn.releaseOrFirstAirDate.toString()),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      );
  }
}