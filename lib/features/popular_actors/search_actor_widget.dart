import 'package:flutter/material.dart';
import 'package:thespian/components/global_route_observer.dart';
import 'package:thespian/features/popular_actors/search_actor_controller.dart';
import 'package:thespian/features/popular_actors/search_actor_results_grid_view.dart';

class SearchActorWidget extends StatefulWidget {
  const SearchActorWidget({super.key});

  @override
  State<SearchActorWidget> createState() => _SearchActorWidgetState();
}

class _SearchActorWidgetState extends State<SearchActorWidget> with RouteAware {
  final _controller = SearchActorController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    globalRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    globalRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _controller.searchAgain();
  }

  void _handleClearIconPressed() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller.searchTextEditingController,
          onSubmitted: (value) => _controller.performSearch(value),
          decoration: InputDecoration(
            hintText: 'Search',
            suffixIcon: IconButton(
              onPressed: _handleClearIconPressed,
              icon: const Icon(Icons.clear, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
      body: Center(
        child: SearchActorResultsGridView(controller: _controller),
      ),
    );
  }
}
