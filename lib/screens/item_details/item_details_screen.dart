import 'package:flutter/material.dart';
import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/extensions/string.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const routeName = 'item-detail';
  final String itemName;

  const ItemDetailsScreen({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName.hyphenToPascalWord()),
        backgroundColor: CategoryColors.items,
      ),
      body: Center(
        child: Text(itemName),
      ),
    );
  }
}
