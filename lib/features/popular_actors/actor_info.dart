import 'package:flutter/material.dart';

class PopularActorInfo extends StatefulWidget {
  const PopularActorInfo({Key? key}) : super(key: key);

  @override
  State<PopularActorInfo> createState() => _PopularActorInfoState();
}

class _PopularActorInfoState extends State<PopularActorInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actor Info'),
      ),
      body: const Center(
        child: Text('Actor Info'),
      )
    );
  }
}