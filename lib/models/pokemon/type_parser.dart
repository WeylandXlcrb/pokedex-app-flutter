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
      default:
        return Colors.blueGrey;
    }
  }

// TODO: implement icons getter
}
