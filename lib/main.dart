import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:thespian/components/global_route_observer.dart';
import 'package:thespian/features/popular_actors/home_page.dart';
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
    return MaterialApp( // GetMaterialApp is a wrapper around MaterialApp
      title: 'Thespian',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PopularActorsHomePage(title: 'Thespian'),
      navigatorObservers: [globalRouteObserver],
    );
  }
}
