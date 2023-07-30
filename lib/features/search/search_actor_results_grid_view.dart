import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespian/common/media_types.dart';
import 'package:thespian/components/actor_info.dart';
import 'package:thespian/components/actor_profile_image.dart';
import 'package:thespian/features/search/search_actor_controller.dart';

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
          if (controller.searchResults.isEmpty) {
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
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final searchResult = controller.searchResults[index];
                  final actorName = searchResult.name;
                  return GridTile(
                      footer: GridTileBar(
                        backgroundColor: Colors.black45,
                        title: Text(actorName),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (searchResult.mediaType == mediaTypePerson) {
                            final actor = controller.toPopularActor(searchResult);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PopularActorInfo(popularActor: actor)));
                          }
                        },
                        child: ActorProfileImage(
                            imageUrl: searchResult.smallImageUrl,
                            width: 200,
                            height: 200),
                      ));
                });
          }
        }));
  }
}
