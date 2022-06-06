import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/version_encounter_detail.dart';

part 'pokemon_encounter.g.dart';

abstract class PokemonEncounter
    implements Built<PokemonEncounter, PokemonEncounterBuilder> {
  static Serializer<PokemonEncounter> get serializer =>
      _$pokemonEncounterSerializer;

  /// The Pokémon being encountered.
  NamedAPIResource get pokemon;

  /// A list of versions and encounters with Pokémon that might happen in
  /// the referenced location area.
  @BuiltValueField(wireName: 'version_details')
  BuiltList<VersionEncounterDetail> get versionDetails;

  PokemonEncounter._();

  factory PokemonEncounter([void Function(PokemonEncounterBuilder) updates]) =
      _$PokemonEncounter;
}
