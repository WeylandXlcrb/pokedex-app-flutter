import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_species_dex_entry.g.dart';

abstract class PokemonSpeciesDexEntry
    implements Built<PokemonSpeciesDexEntry, PokemonSpeciesDexEntryBuilder> {
  static Serializer<PokemonSpeciesDexEntry> get serializer =>
      _$pokemonSpeciesDexEntrySerializer;

  /// The index number within the Pokédex.
  @BuiltValueField(wireName: 'entry_number')
  int get entryNumber;

  /// The Pokédex the referenced Pokémon species can be found in.
  NamedAPIResource get pokedex;

  PokemonSpeciesDexEntry._();

  factory PokemonSpeciesDexEntry(
          [void Function(PokemonSpeciesDexEntryBuilder) updates]) =
      _$PokemonSpeciesDexEntry;
}
