import 'package:flutter/material.dart';

class SearchActorWidget extends StatefulWidget {
  const SearchActorWidget({super.key});

  @override
  _SearchActorWidgetState createState() => _SearchActorWidgetState();
}

class _SearchActorWidgetState extends State<SearchActorWidget> {
  final _controller = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String keyword) {
    // TODO: Implement the search API call
    // In this example, we'll just generate some fake results
    setState(() {
      _searchResults = List.generate(
        10,
            (index) => '$keyword Result ${index + 1}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          onSubmitted: (value) => _performSearch(value),
          decoration: const InputDecoration(
            hintText: 'Search',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_searchResults[index]),
        ),
      ),
    );
  }
}
