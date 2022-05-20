import 'package:flutter/material.dart';
import 'package:pokedex_app/constants.dart';

import 'package:pokedex_app/models/pokemon/pokemon.dart';

class PokemonAboutTab extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonAboutTab({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ABOUT TAB BUILD');
    return CustomScrollView(
      slivers: [
        // Required to not allow body scroll under sliver header
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(kPaddingDefault * 2),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DataHeading(
                    text: 'Pokedex Data', color: pokemon.types.first.color),
                _DataRow(
                  labelText: 'Height',
                  child: _DataTextValue(text: '${pokemon.heightInCm}cm.'),
                ),
                _DataRow(
                  labelText: 'Weight',
                  child: _DataTextValue(text: '${pokemon.weightInKg}kg.'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DataHeading extends StatelessWidget {
  final String text;
  final Color color;

  const _DataHeading({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String labelText;
  final Widget child;

  const _DataRow({
    Key? key,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              labelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _DataTextValue extends StatelessWidget {
  final String text;

  const _DataTextValue({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Color(0xFF666666)),
    );
  }
}
