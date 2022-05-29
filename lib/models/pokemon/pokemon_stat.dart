import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/extensions/string.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_stat.g.dart';

abstract class PokemonStat implements Built<PokemonStat, PokemonStatBuilder> {
  static Serializer<PokemonStat> get serializer => _$pokemonStatSerializer;

  /// The stat the Pokémon has.
  NamedAPIResource get stat;

  /// The effort points (EV) the Pokémon has in the stat.
  int get effort;

  /// The base value of the stat.
  @BuiltValueField(wireName: 'base_stat')
  int get baseStat;

  String get name => stat.name == 'hp'
      ? stat.name.toUpperCase()
      : stat.name.hyphenToPascalWord();

  PokemonStat._();

  factory PokemonStat([void Function(PokemonStatBuilder) updates]) =
      _$PokemonStat;
}
