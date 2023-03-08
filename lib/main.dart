import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:thespian/features/popular_actors/popular_actors_grid_view.dart';
import 'package:thespian/services/service_locator.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  setupServiceLocator();
  runApp(const ThespianApp());
}

class ThespianApp extends StatelessWidget {
  const ThespianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetMaterialApp is a wrapper around MaterialApp
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
  @override
  void initState() {
    super.initState();
  }

  void searchActors() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: PopularActorsGridView()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: searchActors,
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }
}
