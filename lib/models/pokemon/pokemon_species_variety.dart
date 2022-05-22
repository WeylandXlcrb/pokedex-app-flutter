import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:pokedex_app/models/named_api_resource.dart';

part 'pokemon_species_variety.g.dart';

abstract class PokemonSpeciesVariety
    implements Built<PokemonSpeciesVariety, PokemonSpeciesVarietyBuilder> {
  static Serializer<PokemonSpeciesVariety> get serializer =>
      _$pokemonSpeciesVarietySerializer;

  /// Whether this variety is the default variety.
  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  /// The Pokémon variety.
  NamedAPIResource get pokemon;

  PokemonSpeciesVariety._();

  factory PokemonSpeciesVariety(
          [void Function(PokemonSpeciesVarietyBuilder) updates]) =
      _$PokemonSpeciesVariety;
}
