import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/repos/items_repo.dart';
import 'package:pokedex_app/screens/item_details/widgets/app_bar_bottom.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemons/widgets/pokemon_card.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

const _spacer = SliverToBoxAdapter(child: SizedBox(height: 8.0));
const _defaultPadding = EdgeInsets.symmetric(horizontal: kPaddingDefault);

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
        final Widget body;

        if (snapshot.hasError) {
          body = Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          body = _ScreenBody(item: snapshot.data!);
        } else {
          body = const Center(child: PokeballLoadingIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title:
                snapshot.hasData ? null : Text(itemName.hyphenToPascalWord()),
            backgroundColor: TypeColors.unknown,
            bottom: AppBarBottom(item: snapshot.data),
          ),
          body: body,
        );
      },
    );
  }
}

class _ScreenBody extends StatelessWidget {
  final Item item;

  const _ScreenBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _SliverChild(
          padding: _defaultPadding.copyWith(top: kPaddingDefault),
          child: Text(item.flavorTextDefault.text.replaceAll('\n', ' ')),
        ),
        _spacer,
        const _SliverChild(
          child: _DataRow(label: 'Effect', value: ''),
        ),
        _spacer,
        _SliverChild(
          child: Text(item.effectDefault.effect.replaceNewLineTo()),
        ),
        _spacer,
        _SliverChild(
          child: _DataRow(
            label: 'Category',
            value: item.category.name.hyphenToPascalWord(),
          ),
        ),
        _spacer,
        _SliverChild(
          child: _DataRow(label: 'Cost', value: '${item.cost}'),
        ),
        _spacer,
        _SliverChild(
          child: _DataRow(
            label: 'Fling Effect',
            value: item.flingEffect.name.hyphenToPascalWord(),
          ),
        ),
        _spacer,
        _SliverChild(
          child: _DataRow(
            label: 'Fling Power',
            value: '${item.flingPower ?? 'Unknown'}',
          ),
        ),
        _spacer,
        _SliverChild(
          child: Wrap(
            spacing: 16.0,
            children: [
              for (final attr in item.attributes)
                Chip(
                  label: Text(attr.name.hyphenToPascalWord()),
                ),
            ],
          ),
        ),
        _spacer,
        if (item.heldByPokemons.isNotEmpty) ...[
          const _SliverChild(
            child: _DataRow(label: 'Held By', value: ''),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(kPaddingDefault),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, idx) {
                  if (idx % 2 == 1) {
                    return const SizedBox(height: 16.0);
                  }

                  final pokemon = item.heldByPokemons[idx ~/ 2].pokemon;

                  return PokemonCard(
                    pokemonName: pokemon.name,
                    onTap: () => context.pushNamed(
                      PokemonDetailsScreen.routeName,
                      params: {'name': pokemon.name},
                    ),
                  );
                },
                childCount: item.heldByPokemons.length * 2 - 1,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SliverChild extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const _SliverChild({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? _defaultPadding,
      sliver: SliverToBoxAdapter(child: child),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;

  const _DataRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(value),
      ],
    );
  }
}
