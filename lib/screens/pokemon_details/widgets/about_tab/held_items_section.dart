import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/items_repo.dart';
import 'package:pokedex_app/screens/item_details/item_details_screen.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/section_and_data.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';

class HeldItemsSection extends StatelessWidget {
  const HeldItemsSection({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DataSection(
      title: 'Held Items',
      subtitle: 'A list of items this Pokémon may be holding when encountered.',
      color: pokemon.types.first.color,
      children: [
        if (pokemon.heldItems.isNotEmpty)
          for (final heldItem in pokemon.heldItems)
            FutureBuilder<Item>(
              future: context.read<ItemsRepo>().getItem(heldItem.item.name),
              builder: (context, snapshot) => ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                leading: ItemImage(
                  item: snapshot.data,
                  duration: const Duration(milliseconds: 400),
                  imageSize: 50,
                ),
                title: Text(heldItem.item.name.hyphenToPascalWord()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                onTap: () => context.pushNamed(
                  ItemDetailsScreen.routeName,
                  params: {'name': heldItem.item.name},
                ),
              ),
            )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: DataTextValue(text: 'No Data Available...'),
          )
      ],
    );
  }
}
