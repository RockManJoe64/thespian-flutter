import 'package:flutter/material.dart';
import 'package:thespian/features/search_actors/search_actor_widget.dart';

import 'grid_view.dart';
import 'grid_view_controller.dart';

class PopularActorsHomePage extends StatefulWidget {
  const PopularActorsHomePage({super.key, required this.title});

  final String title;

  @override
  State<PopularActorsHomePage> createState() => _PopularActorsHomePageState();
}

class _PopularActorsHomePageState extends State<PopularActorsHomePage> {
  final PopularActorsGridViewController controller = PopularActorsGridViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PopularActorsGridView(controller: controller)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchActorWidget())
          );
        },
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}