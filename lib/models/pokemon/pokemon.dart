import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move.dart';
import 'package:pokedex_app/models/pokemon/pokemon_sprites.dart';
import 'package:pokedex_app/models/pokemon/pokemon_stat.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type_past.dart';
import 'package:pokedex_app/models/version_game_index.dart';

part 'pokemon.g.dart';

abstract class Pokemon implements Built<Pokemon, PokemonBuilder> {
  static Serializer<Pokemon> get serializer => _$pokemonSerializer;

  int get id;

  String get name;

  /// The base experience gained for defeating this Pokémon.
  @BuiltValueField(wireName: 'base_experience')
  int get baseExperience;

  /// The height of the Pokémon in decimetres.
  int get height;

  /// Set for exactly one Pokémon used as the default for each species.
  @BuiltValueField(wireName: 'is_default')
  bool get isDefault;

  /// Order for sorting. Almost national order, except families are grouped
  /// together.
  int get order;

  /// The weight of this Pokémon in hectograms.
  int get weight;

  /// A list of abilities this Pokémon could potentially have.
  BuiltList<PokemonAbility> get abilities;

  /// A list of forms this Pokémon can take on.
  BuiltList<NamedAPIResource> get forms;

  /// A list of game indices relevent to Pokémon item by generation.
  @BuiltValueField(wireName: 'game_indices')
  BuiltList<VersionGameIndex> get gameIndices;

  /// A list of items this Pokémon may be holding when encountered.
  @BuiltValueField(wireName: 'held_items')
  BuiltList<PokemonHeldItem> get heldItems;

  /// A link to a list of location areas, as well as encounter details
  /// pertaining to specific versions.
  @BuiltValueField(wireName: 'location_area_encounters')
  String get locationAreaEncounters;

  /// A list of moves along with learn methods and level details pertaining to
  /// specific version groups.
  BuiltList<PokemonMove> get moves;

  /// A list of details showing types this pokémon had in previous generations
  @BuiltValueField(wireName: 'past_types')
  BuiltList<PokemonTypePast> get pastTypes;

  /// A set of sprites used to depict this Pokémon in the game. A visual
  /// representation of the various sprites can be found at PokeAPI/sprites
  /// (https://github.com/PokeAPI/sprites#sprites)
  PokemonSprites get sprites;

  /// The species this Pokémon belongs to.
  NamedAPIResource get species;

  /// A list of base stat values for this Pokémon.
  BuiltList<PokemonStat> get stats;

  /// A list of details showing types this Pokémon has.
  BuiltList<PokemonType> get types;

  String get hashedId => '#${id.toString().padLeft(3, '0')}';

  Pokemon._();

  factory Pokemon([void Function(PokemonBuilder) updates]) = _$Pokemon;
}
