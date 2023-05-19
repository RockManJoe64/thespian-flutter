import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespian/components/actor_profile_image.dart';
import 'package:thespian/features/popular_actors/actor_info.dart';
import 'package:thespian/features/popular_actors/search_actor_controller.dart';

class SearchActorResultsGridView extends StatelessWidget {
  final SearchActorController controller;

  const SearchActorResultsGridView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => controller,
        child: Consumer<SearchActorController>(
            builder: (context, controller, child) {
          if (controller.actorSearchResults.isEmpty) {
            return const Center(child: Icon(Icons.search, size: 100));
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
                itemCount: controller.actorSearchResults.length,
                itemBuilder: (context, index) {
                  final actor = controller.actorSearchResults[index];
                  final actorName = actor.name;
                  return GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(actorName),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PopularActorInfo(popularActor: actor)));
                        },
                        child: ActorProfileImage(
                            imageUrl: actor.smallProfileImageUrl,
                            width: 200,
                            height: 200),
                      ));
                });
          }
        }));
  }
}
