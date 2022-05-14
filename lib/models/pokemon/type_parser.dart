import 'package:flutter/material.dart';
import 'package:pokedex_app/colors.dart';

abstract class TypeParser {
  String get name;

  Color get color {
    switch (name) {
      case 'grass':
        return TypeColors.grass;
      case 'poison':
        return TypeColors.poison;
      case 'fire':
        return TypeColors.fire;
      case 'flying':
        return TypeColors.flying;
      case 'water':
        return TypeColors.water;
      case 'bug':
        return TypeColors.bug;
      case 'normal':
        return TypeColors.normal;
      case 'electric':
        return TypeColors.electric;
      case 'ground':
        return TypeColors.ground;
      case 'fairy':
        return TypeColors.fairy;
      case 'fighting':
        return TypeColors.fighting;
      case 'psychic':
        return TypeColors.psychic;
      case 'rock':
        return TypeColors.rock;
      case 'steel':
        return TypeColors.steel;
      case 'ghost':
        return TypeColors.ghost;
      case 'ice':
        return TypeColors.ice;
      case 'dragon':
        return TypeColors.dragon;
      case 'dark':
        return TypeColors.dark;
      default:
        return Colors.blueGrey;
    }
  }

// TODO: implement icons getter
}
