import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:thespian/features/popular_actors/popular_actors_grid_view.dart';
import 'package:thespian/models/transformers.dart';
import 'package:thespian/services/service_locator.dart';
import 'package:thespian/tmdb/tmdb_configuration_service.dart';
import 'package:thespian/tmdb/tmdb_person_service.dart';

import 'models/actor.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupServiceLocator();
  runApp(const ThespianApp());
}

class ThespianApp extends StatelessWidget {
  const ThespianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thespian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Thespian'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TMDBConfigurationService _tmdbConfigurationService = getIt<TMDBConfigurationService>();
  final TMDBPersonService _tmdbPersonService = getIt<TMDBPersonService>();
  List<Actor> actors = [];

  @override
  void initState() {
    super.initState();
    _fetchPopularActors();
  }

  void _fetchPopularActors() async {
    final config = await _tmdbConfigurationService.fetchImageConfiguration();
    final response = await _tmdbPersonService.fetchPopularPeople();

    setState(() {
      actors = convertToActors(config, response);
      actors.sort((a, b) => b.popularity.compareTo(a.popularity));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PopularActorsGridView(actors: actors),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPopularActors,
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}
