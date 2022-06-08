import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/repos/items_repo.dart';
import 'package:pokedex_app/screens/item_details/widgets/app_bar_bottom.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const routeName = 'item-detail';
  final String itemName;

  const ItemDetailsScreen({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: context.read<ItemsRepo>().getItem(itemName),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title:
                snapshot.hasData ? null : Text(itemName.hyphenToPascalWord()),
            backgroundColor: TypeColors.unknown,
            bottom: AppBarBottom(item: snapshot.data),
          ),
          body: Center(
            child: Text(itemName),
          ),
        );
      },
    );
  }
}
