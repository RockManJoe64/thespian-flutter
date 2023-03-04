import 'package:flutter/material.dart';
import 'package:thespian/components/actor_grid_image.dart';

import 'package:thespian/models/actor.dart';

class PopularActorsGridView extends StatelessWidget {
  final List<Actor> actors;

  const PopularActorsGridView({Key? key, required this.actors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: actors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final person = actors[index];
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(person.name ?? ''),
            ),
            child: ActorGridImage(imageUrl: person.profileImageUrl),
          );
        });
  }
}
