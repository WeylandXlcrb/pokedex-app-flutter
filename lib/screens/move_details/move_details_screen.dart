import 'package:flutter/material.dart';
import 'package:pokedex_app/colors.dart';

import 'package:pokedex_app/extensions/string.dart';

class MoveDetailsScreen extends StatelessWidget {
  static const routeName = 'move-details';

  final String moveName;

  const MoveDetailsScreen({
    Key? key,
    required this.moveName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moveName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.moves,
        elevation: 0,
      ),
      body: Center(
        child: Text(moveName),
      ),
    );
  }
}
