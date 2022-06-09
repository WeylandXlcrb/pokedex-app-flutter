import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:pokedex_app/asset_images.dart';
import 'package:pokedex_app/constants.dart';
import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/chain_link.dart';
import 'package:pokedex_app/models/pokemon/evolution_chain.dart';
import 'package:pokedex_app/models/pokemon/evolution_detail.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/repos/pokemons_repo.dart';
import 'package:pokedex_app/screens/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex_app/screens/pokemon_details/widgets/overlap_injector_scroll_view.dart';
import 'package:pokedex_app/widgets/pokemon_image.dart';
import 'package:pokedex_app/widgets/pokeball_loading_indicator.dart';

class PokemonEvolutionTab extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonEvolutionTab({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlapInjectorScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
          sliver: SliverToBoxAdapter(
            child: FutureBuilder<EvolutionChain>(
              future: context
                  .read<PokemonsRepo>()
                  .getEvolutionChain(pokemon.speciesId),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return _EvolutionChain(
                    chainLink: snapshot.data!.chain,
                    currentPokemon: pokemon,
                  );
                }

                return const Center(child: PokeballLoadingIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _EvolutionChain extends StatelessWidget {
  static const _spacer = SizedBox(height: 16.0);
  final ChainLink chainLink;
  final Pokemon currentPokemon;

  const _EvolutionChain({
    Key? key,
    required this.chainLink,
    required this.currentPokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (chainLink.evolvesTo.isEmpty)
          Center(
            child: _PokemonLink(
              pokemonName: chainLink.species.name,
              currentPokemon: currentPokemon,
            ),
          )
        else
          for (final link in chainLink.evolvesTo) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PokemonLink(
                  pokemonName: chainLink.species.name,
                  currentPokemon: currentPokemon,
                ),
                if (link.evolutionDetails.isNotEmpty)
                  _EvoLinkDetails(detail: link.evolutionDetails.first),
                _PokemonLink(
                  pokemonName: link.species.name,
                  currentPokemon: currentPokemon,
                ),
              ],
            ),
            if (link.evolvesTo.isNotEmpty) ...[
              _spacer,
              _EvolutionChain(
                chainLink: link,
                currentPokemon: currentPokemon,
              ),
            ],
            _spacer,
          ],
      ],
    );
  }
}

class _EvoLinkDetails extends StatelessWidget {
  final EvolutionDetail detail;

  const _EvoLinkDetails({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(detail.trigger.name.hyphenToPascalWord()),
        const Icon(Icons.arrow_forward),
        if (detail.minLevel != null)
          Text(
            'Lvl. ${detail.minLevel}+',
            style: const TextStyle(fontSize: 12.0),
          ),
        if (detail.minHappiness != null)
          Text(
            'Happiness ${detail.minHappiness}+',
            style: const TextStyle(fontSize: 12.0),
          ),
        if (detail.item != null)
          Text(
            detail.item!.name.hyphenToPascalWord(),
            style: const TextStyle(fontSize: 12.0),
          ),
      ],
    );
  }
}

class _PokemonLink extends StatelessWidget {
  static const _transitionDuration = Duration(milliseconds: 400);

  final String pokemonName;
  final Pokemon currentPokemon;

  const _PokemonLink({
    Key? key,
    required this.pokemonName,
    required this.currentPokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: context.read<PokemonsRepo>().getPokemonByName(pokemonName),
      builder: (_, snapshot) {
        final isSameAsCurrent = currentPokemon.name == pokemonName;
        final Widget image;

        if (snapshot.hasError) {
          image = Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          image = PokemonImage(
            pokemon: snapshot.data!,
            duration: _transitionDuration,
          );
        } else {
          image = const Center(child: PokeballLoadingIndicator());
        }

        return GestureDetector(
          onTap: snapshot.data != null && !isSameAsCurrent
              ? () => context.pushNamed(
                    PokemonDetailsScreen.routeName,
                    params: {'name': snapshot.data!.name},
                  )
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 100,
                child: Stack(
                  children: [
                    Image.asset(
                      AssetImages.pokeball,
                      color: isSameAsCurrent
                          ? currentPokemon.types.first.color.withOpacity(0.5)
                          : Colors.black.withOpacity(0.05),
                    ),
                    image,
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: snapshot.data?.id ?? 0),
                duration: _transitionDuration,
                builder: (_, id, __) => Text(
                  '#${'$id'.padLeft(3, '0')}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Theme.of(context).textTheme.caption?.color,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
              AnimatedCrossFade(
                firstChild: const Text('-------'),
                secondChild: Text(snapshot.data?.name.capitalize() ?? ''),
                duration: _transitionDuration,
                crossFadeState: snapshot.data != null
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        );
      },
    );
  }
}
