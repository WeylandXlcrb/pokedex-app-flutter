import 'package:flutter/material.dart';
import 'package:pokedex_app/colors.dart';
import 'package:pokedex_app/pokedex_icons.dart';

const _colorMap = {
  'grass': TypeColors.grass,
  'poison': TypeColors.poison,
  'fire': TypeColors.fire,
  'flying': TypeColors.flying,
  'water': TypeColors.water,
  'bug': TypeColors.bug,
  'normal': TypeColors.normal,
  'electric': TypeColors.electric,
  'ground': TypeColors.ground,
  'fairy': TypeColors.fairy,
  'fighting': TypeColors.fighting,
  'psychic': TypeColors.psychic,
  'rock': TypeColors.rock,
  'steel': TypeColors.steel,
  'ghost': TypeColors.ghost,
  'ice': TypeColors.ice,
  'dragon': TypeColors.dragon,
  'dark': TypeColors.dark,
};

const _iconMap = {
  'grass': PokedexIcons.grass,
  'poison': PokedexIcons.poison,
  'fire': PokedexIcons.fire,
  'flying': PokedexIcons.flying,
  'water': PokedexIcons.water,
  'bug': PokedexIcons.bug,
  'normal': PokedexIcons.normal,
  'electric': PokedexIcons.electric,
  'ground': PokedexIcons.ground,
  'fairy': PokedexIcons.fairy,
  'fighting': PokedexIcons.fighting,
  'psychic': PokedexIcons.psychic,
  'rock': PokedexIcons.rock,
  'steel': PokedexIcons.steel,
  'ghost': PokedexIcons.ghost,
  'ice': PokedexIcons.ice,
  'dragon': PokedexIcons.dragon,
  'dark': PokedexIcons.dark,
};

abstract class TypeParser {
  String get name;

  // Static methods To support those places where including mixin will be
  // meaningless (e.g. type relations where every field is just list of
  // [NamedAPIResource] for type, not type itself)
  static Color getColorByName(String name) =>
      _colorMap[name] ?? TypeColors.unknown;

  static IconData getIconByName(String name) =>
      _iconMap[name] ?? Icons.question_mark;

  Color get color => getColorByName(name);

  Color get dimColor => Color.alphaBlend(
        Colors.white.withOpacity(0.1),
        color,
      );

  IconData get icon => getIconByName(name);
}
