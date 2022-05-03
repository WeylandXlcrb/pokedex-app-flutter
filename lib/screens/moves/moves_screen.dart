import 'package:flutter/material.dart';

class MovesScreen extends StatelessWidget {
  static const routeName = 'moves';

  const MovesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Moves List'),
      ),
    );
  }
}
