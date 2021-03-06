import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:pokedex_app/models/api_resource.dart';
import 'package:pokedex_app/models/description.dart';
import 'package:pokedex_app/models/effect.dart';
import 'package:pokedex_app/models/encounter.dart';
import 'package:pokedex_app/models/flavor_text.dart';
import 'package:pokedex_app/models/generation_game_index.dart';
import 'package:pokedex_app/models/item/item.dart';
import 'package:pokedex_app/models/item/item_holder_pokemon.dart';
import 'package:pokedex_app/models/item/item_sprites.dart';
import 'package:pokedex_app/models/location/encounter_method_rate.dart';
import 'package:pokedex_app/models/location/encounter_version_details.dart';
import 'package:pokedex_app/models/location/location.dart';
import 'package:pokedex_app/models/location/location_area.dart';
import 'package:pokedex_app/models/location/pokemon_encounter.dart';
import 'package:pokedex_app/models/location/region.dart';
import 'package:pokedex_app/models/machine_version_detail.dart';
import 'package:pokedex_app/models/move/contest_combo_detail.dart';
import 'package:pokedex_app/models/move/contest_combo_sets.dart';
import 'package:pokedex_app/models/move/move.dart';
import 'package:pokedex_app/models/move/move_meta_data.dart';
import 'package:pokedex_app/models/move/move_stat_change.dart';
import 'package:pokedex_app/models/move/past_move_stat_values.dart';
import 'package:pokedex_app/models/name.dart';
import 'package:pokedex_app/models/named_api_resource.dart';
import 'package:pokedex_app/models/named_api_resource_list.dart';
import 'package:pokedex_app/models/pokemon/ability.dart';
import 'package:pokedex_app/models/pokemon/ability_effect_change.dart';
import 'package:pokedex_app/models/version_encounter_detail.dart';
import 'package:pokedex_app/models/version_group_flavor_text.dart';
import 'package:pokedex_app/models/pokemon/ability_pokemon.dart';
import 'package:pokedex_app/models/pokemon/chain_link.dart';
import 'package:pokedex_app/models/pokemon/evolution_chain.dart';
import 'package:pokedex_app/models/pokemon/evolution_detail.dart';
import 'package:pokedex_app/models/pokemon/genus.dart';
import 'package:pokedex_app/models/pokemon/pal_park_encounter_area.dart';
import 'package:pokedex_app/models/pokemon/pokemon.dart';
import 'package:pokedex_app/models/pokemon/pokemon_ability.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item.dart';
import 'package:pokedex_app/models/pokemon/pokemon_held_item_version.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move.dart';
import 'package:pokedex_app/models/pokemon/pokemon_move_version.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_dex_entry.dart';
import 'package:pokedex_app/models/pokemon/pokemon_species_variety.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_and_shiny_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/front_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/other_sprites.dart';
import 'package:pokedex_app/models/pokemon/sprite/pokemon_sprites.dart';
import 'package:pokedex_app/models/pokemon/pokemon_stat.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type.dart';
import 'package:pokedex_app/models/pokemon/pokemon_type_past.dart';
import 'package:pokedex_app/models/pokemon/type.dart';
import 'package:pokedex_app/models/pokemon/type_pokemon.dart';
import 'package:pokedex_app/models/pokemon/type_relations.dart';
import 'package:pokedex_app/models/pokemon/type_relations_past.dart';
import 'package:pokedex_app/models/verbose_effect.dart';
import 'package:pokedex_app/models/version_game_index.dart';

part 'serializers.g.dart';

@SerializersFor([
  // COMMON
  APIResource,
  Description,
  Effect,
  Encounter,
  FlavorText,
  GenerationGameIndex,
  MachineVersionDetail,
  NamedAPIResource,
  NamedAPIResourceList,
  Name,
  VerboseEffect,
  VersionEncounterDetail,
  VersionGameIndex,
  VersionGroupFlavorText,
  // POKEMON
  Pokemon,
  PokemonAbility,
  PokemonHeldItemVersion,
  PokemonHeldItem,
  PokemonMoveVersion,
  PokemonMove,
  PokemonType,
  PokemonTypePast,
  PokemonSprites,
  PokemonStat,
  FrontSprites,
  FrontAndShinySprites,
  OtherSprites,
  // POKEMON SPECIES
  PokemonSpeciesDexEntry,
  PalParkEncounterArea,
  Genus,
  PokemonSpeciesVariety,
  PokemonSpecies,
  // ABILITY
  Ability,
  AbilityEffectChange,
  AbilityPokemon,
  // TYPE
  TypeP,
  TypeRelations,
  TypeRelationsPast,
  TypePokemon,
  // EVOLUTION
  EvolutionChain,
  ChainLink,
  EvolutionDetail,
  // MOVE
  Move,
  ContestComboSets,
  ContestComboDetail,
  MoveMetaData,
  PastMoveStatValues,
  MoveStatChange,
  // Location
  Location,
  LocationArea,
  EncounterMethodRate,
  EncounterVersionDetails,
  PokemonEncounter,
  Region,
  // Item
  Item,
  ItemSprites,
  ItemHolderPokemon,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
