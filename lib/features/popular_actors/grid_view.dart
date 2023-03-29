import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespian/components/actor_grid_image.dart';

import 'grid_view_controller.dart';

class PopularActorsGridView extends StatelessWidget {
  final PopularActorsGridViewController controller;

  const PopularActorsGridView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Consumer<PopularActorsGridViewController>(
        builder: (context, controller, child) {
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/actor_info', arguments: actor);
                      },
                      child: ActorGridImage(imageUrl: actor.profileImageUrl),
                    )
                );
              });
          }
        }
      )
    );
  }
}
