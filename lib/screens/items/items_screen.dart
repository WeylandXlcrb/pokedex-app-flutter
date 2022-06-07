import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/repos/items_repo.dart';
import 'package:pokedex_app/screens/item_details/item_details_screen.dart';
import 'package:pokedex_app/widgets/paginated_resource_list.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';

class ItemsScreen extends StatelessWidget {
  static const routeName = 'items';

  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        backgroundColor: CategoryColors.items,
      ),
      body: PaginatedResourceGrid(
        pageFetcher: context.read<ItemsRepo>().getItems,
        itemBuilder: (_, __, resource) => _ItemCard(itemName: resource.name),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String itemName;

  const _ItemCard({
    Key? key,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.topLeft,
          colors: [TypeColors.unknown, CategoryColors.items],
          radius: 1.5,
          stops: [0.5, 1],
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: TypeColors.unknown.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) => FutureBuilder<Item>(
          future: context.read<ItemsRepo>().getItem(itemName),
          builder: (context, snapshot) => Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                bottom: -constraints.maxWidth * 0.05,
                left: -constraints.maxWidth * 0.025,
                child: Image.asset(
                  AssetImages.dotted,
                  color: Colors.white12,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemImage(
                    item: snapshot.data,
                    duration: const Duration(milliseconds: 400),
                    hasError: snapshot.hasError,
                    imageSize: constraints.maxWidth * 0.5,
                  ),
                  if (snapshot.hasData) ...[
                    const SizedBox(height: 8.0),
                    Text(
                      snapshot.data!.name.hyphenToPascalWord(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
              GestureDetector(
                onTap: () => context.goNamed(
                  ItemDetailsScreen.routeName,
                  params: {'name': snapshot.data!.name},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
