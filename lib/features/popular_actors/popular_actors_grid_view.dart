import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thespian/components/actor_grid_image.dart';
import 'package:thespian/features/popular_actors/popular_actors_controller.dart';

class PopularActorsGridView extends StatelessWidget {
  const PopularActorsGridView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<PopularActorsGridViewController>(
      init: PopularActorsGridViewController(),
      builder: (controller) {
        if (controller.popularActors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: controller.popularActors.length,
            itemBuilder: (context, index) {
              final actor = controller.popularActors[index];
              final actorName = actor.name;
              return GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: Text(actorName),
                ),
                child: ActorGridImage(imageUrl: actor.profileImageUrl),
              );
            });
        }
      },
    );
  }
}
